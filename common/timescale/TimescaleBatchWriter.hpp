#pragma once

#include <chrono>
#include <condition_variable>
#include <atomic>
#include <algorithm>
#include <cmath>
#include <filesystem>
#include <deque>
#include <fstream>
#include <iomanip>
#include <iostream>
#include <map>
#include <mutex>
#include <optional>
#include <set>
#include <sstream>
#include <string>
#include <thread>
#include <unordered_set>
#include <vector>

#include <nlohmann/json.hpp>

#include "../models/WeatherPacket.hpp"
#include "../protocol/MessageEnvelope.hpp"
#include "TimescaleDbClient.hpp"
#include "../metrics/Metrics.hpp"

using json = nlohmann::json;

struct TimescaleRawRow {
    std::string message_id;
    std::string source;
    std::string continent;
    std::string country;
    std::string region;
    std::string city;
    long event_time;
    long created_at;
    double latitude;
    double longitude;
    double temperature;
    double humidity;
    double wind_speed;
    double visibility_km;
    double precipitation_mm;
    double pressure_hpa;
    double cloud_cover_percent;
    std::string station_id;
    std::string ingest_layer;
    std::string sample_point;
    std::string payload_json;
};

struct TimescaleAggregateRow {
    long bucket_start;
    std::string continent;
    std::string country;
    std::string region;
    std::string city;
    std::size_t observation_count;
    double min_temperature;
    double max_temperature;
    double avg_temperature;
    double avg_humidity;
    double avg_wind_speed;
};

struct TimescaleTileAggregateRow {
    long bucket_start;
    std::string tile_id;
    std::string continent;
    std::string country;
    std::string region;
    std::size_t sample_count;
    std::optional<double> latitude;
    std::optional<double> longitude;
    double avg_temperature;
    double avg_humidity;
    std::optional<double> avg_cloud_cover;
    double avg_wind_speed;
    std::optional<double> avg_pressure_hpa;
    std::optional<double> min_visibility_km;
    std::optional<double> max_precipitation_mm;
    double hazard_score;
};

struct TimescaleRouteRiskRow {
    long bucket_start;
    std::string route_id;
    std::string segment_id;
    std::string region;
    double hazard_score;
    double delay_factor;
    std::string primary_hazard;
};

class TimescaleBatchWriter {
public:
    TimescaleBatchWriter(std::string outboxPath,
                         std::size_t maxQueueSize = 1024,
                         std::size_t batchSize = 100,
                         std::chrono::milliseconds flushInterval = std::chrono::milliseconds(1000))
        : outboxPath_(std::move(outboxPath)),
          maxQueueSize_(maxQueueSize),
          batchSize_(batchSize),
                    flushInterval_(flushInterval),
                    timescaleDb_() {}

    bool submit(const MessageEnvelope& envelope) {
        auto packet = weather_packet_from_envelope(envelope);
        if (!packet.has_value()) {
            std::cerr << "[TimescaleWriter] Rejected invalid envelope " << envelope.message_id << std::endl;
            return false;
        }

        std::unique_lock<std::mutex> lock(mutex_);
        if (pending_.size() >= maxQueueSize_) {
            std::cerr << "[TimescaleWriter] Backpressure: queue full, rejecting " << envelope.message_id << std::endl;
            return false;
        }

        if (seenIds_.count(envelope.message_id)) {
            std::cout << "[TimescaleWriter] Duplicate envelope ignored: " << envelope.message_id << std::endl;
            return true;
        }

        // Bounded duplicate cache (FIFO eviction)
        if (seenIds_.size() >= 10000) {
            auto it = seenIds_.find(idOrder_.front());
            if (it != seenIds_.end()) {
                seenIds_.erase(it);
            }
            idOrder_.pop_front();
        }
        seenIds_.insert(envelope.message_id);
        idOrder_.push_back(envelope.message_id);

        pending_.push_back(std::move(envelope));
        cv_.notify_one();
        return true;
    }

    void run(std::atomic<bool>& running) {
        std::cout << "[TimescaleWriter] Batch writer started, backend: " << timescaleDb_.backendName() << std::endl;
        if (timescaleDb_.backendName() == "file outbox") {
            std::cout << "[TimescaleWriter] Outbox fallback: " << outboxPath_ << std::endl;
        } else {
            replayOutboxIfPresent();
        }

        while (running.load()) {
            std::vector<MessageEnvelope> batch;

            {
                std::unique_lock<std::mutex> lock(mutex_);
                cv_.wait_for(lock, flushInterval_, [&]() {
                    return !pending_.empty() || !running.load();
                });

                while (!pending_.empty() && batch.size() < batchSize_) {
                    batch.push_back(std::move(pending_.front()));
                    pending_.pop_front();
                }
            }

            if (!batch.empty()) {
                flushBatch(batch);
            }
        }

        // Final drain
        std::vector<MessageEnvelope> finalBatch;
        {
            std::lock_guard<std::mutex> lock(mutex_);
            while (!pending_.empty()) {
                finalBatch.push_back(std::move(pending_.front()));
                pending_.pop_front();
            }
        }

        if (!finalBatch.empty()) {
            flushBatch(finalBatch);
        }

        std::cout << "[TimescaleWriter] Batch writer stopped" << std::endl;
    }

private:
    static std::string escapeSqlLiteral(const std::string& value) {
        std::string escaped;
        escaped.reserve(value.size() + 8);
        for (char ch : value) {
            if (ch == '\'') {
                escaped += "''";
            } else {
                escaped.push_back(ch);
            }
        }
        return escaped;
    }

    static long minuteBucket(long timestampMs) {
        return (timestampMs / 60000L) * 60000L;
    }

    static long toEpochMs(long rawTimestamp) {
        // WeatherPacket timestamps are already epoch-millisecond values in this pipeline.
        return rawTimestamp;
    }

    static bool hasMeasurement(double value) {
        return !std::isnan(value);
    }

    static double clamp01(double value) {
        return std::max(0.0, std::min(1.0, value));
    }

    static std::string tileIdFromPacket(const WeatherPacket& packet) {
        if (!hasMeasurement(packet.latitude) || !hasMeasurement(packet.longitude)) {
            return packet.region + ":" + packet.city;
        }

        // 1/32-degree buckets give city-scale coverage without exploding key cardinality.
        const int latBucket = static_cast<int>(std::floor((packet.latitude + 90.0) * 32.0));
        const int lonBucket = static_cast<int>(std::floor((packet.longitude + 180.0) * 32.0));
        return "q25:" + std::to_string(latBucket) + ":" + std::to_string(lonBucket);
    }

    static std::string sqlNullableDouble(double value) {
        if (!hasMeasurement(value)) {
            return "NULL";
        }
        std::ostringstream stream;
        stream << value;
        return stream.str();
    }

    static double windNorm(const WeatherPacket& packet) {
        return clamp01(packet.wind_speed / 80.0);
    }

    static double precipNorm(const WeatherPacket& packet) {
        if (!hasMeasurement(packet.precipitation_mm)) {
            return 0.0;
        }
        return clamp01(packet.precipitation_mm / 25.0);
    }

    static double visibilityNorm(const WeatherPacket& packet) {
        if (!hasMeasurement(packet.visibility_km)) {
            return 0.0;
        }
        return clamp01((10.0 - packet.visibility_km) / 10.0);
    }

    static double cloudNorm(const WeatherPacket& packet) {
        if (!hasMeasurement(packet.cloud_cover_percent)) {
            return 0.0;
        }
        return clamp01(packet.cloud_cover_percent / 100.0);
    }

    static double heatNorm(const WeatherPacket& packet) {
        if (packet.temperature >= 15.0 && packet.temperature <= 30.0) {
            return 0.0;
        }

        const double distance = packet.temperature < 15.0 ? (15.0 - packet.temperature)
                                                          : (packet.temperature - 30.0);
        return clamp01(distance / 20.0);
    }

    static double hazardScore(const WeatherPacket& packet) {
        // We include a small cloud cover contribution for Phase 1
        const double score01 = 0.33 * windNorm(packet) +
                               0.28 * precipNorm(packet) +
                               0.19 * visibilityNorm(packet) +
                               0.15 * heatNorm(packet) +
                               0.05 * cloudNorm(packet);
        return score01 * 100.0;
    }

    static std::string primaryHazard(const WeatherPacket& packet) {
        const double wind = windNorm(packet);
        const double precip = precipNorm(packet);
        const double vis = visibilityNorm(packet);
        const double heat = heatNorm(packet);
        const double cloud = cloudNorm(packet);

        if (wind >= precip && wind >= vis && wind >= heat && wind >= cloud) {
            return "wind";
        }
        if (precip >= wind && precip >= vis && precip >= heat && precip >= cloud) {
            return "precipitation";
        }
        if (vis >= wind && vis >= precip && vis >= heat && vis >= cloud) {
            return "visibility";
        }
        if (cloud >= wind && cloud >= precip && cloud >= vis && cloud >= heat) {
            return "cloud";
        }
        return "temperature";
    }

    void flushBatch(const std::vector<MessageEnvelope>& batch) {
        std::vector<TimescaleRawRow> rawRows;
        rawRows.reserve(batch.size());

        std::map<std::tuple<long, std::string, std::string, std::string, std::string>, std::vector<WeatherPacket>> aggregateGroups;
        struct TileAcc {
            std::size_t sample_count = 0;
            double sum_latitude = 0.0;
            double sum_longitude = 0.0;
            std::size_t geo_count = 0;
            double sum_temperature = 0.0;
            double sum_humidity = 0.0;
            double sum_wind = 0.0;
            double sum_pressure = 0.0;
            std::size_t pressure_count = 0;
            double sum_cloud_cover = 0.0;
            std::size_t cloud_count = 0;
            std::optional<double> min_visibility_km;
            std::optional<double> max_precipitation_mm;
            double sum_hazard = 0.0;
        };
        std::map<std::tuple<long, std::string, std::string, std::string, std::string>, TileAcc> tileAggregateGroups;

        struct RouteAcc {
            std::size_t sample_count = 0;
            double sum_hazard = 0.0;
            double sum_delay_factor = 0.0;
            double max_hazard = -1.0;
            std::string primary_hazard = "wind";
        };
        std::map<std::tuple<long, std::string, std::string, std::string>, RouteAcc> routeRiskGroups;

        for (const auto& envelope : batch) {
            auto packetOpt = weather_packet_from_envelope(envelope);
            if (!packetOpt.has_value()) {
                continue;
            }

            const WeatherPacket& packet = *packetOpt;
            const long eventTime = packet.timestamp;
                envelope.created_at,
                packet.latitude,
                packet.longitude,
                packet.temperature,
                packet.humidity,
                packet.wind_speed,
                packet.visibility_km,
                packet.precipitation_mm,
                packet.pressure_hpa,
                packet.cloud_cover_percent,
                packet.station_id,
                packet.ingest_layer,
                packet.sample_point,
                envelope_to_json(envelope).dump()
            });

            aggregateGroups[{minuteBucket(eventTime), packet.continent, packet.country, packet.region, packet.city}].push_back(packet);

            const long bucket = minuteBucket(eventTime);
            const std::string tileId = tileIdFromPacket(packet);
            auto& tileAcc = tileAggregateGroups[{bucket, tileId, packet.continent, packet.country, packet.region}];
            tileAcc.sample_count++;
            tileAcc.sum_temperature += packet.temperature;
            tileAcc.sum_humidity += packet.humidity;
            tileAcc.sum_wind += packet.wind_speed;
            if (hasMeasurement(packet.pressure_hpa)) {
                tileAcc.sum_pressure += packet.pressure_hpa;
                tileAcc.pressure_count++;
            }
            if (hasMeasurement(packet.cloud_cover_percent)) {
                tileAcc.sum_cloud_cover += packet.cloud_cover_percent;
                tileAcc.cloud_count++;
            }
            tileAcc.sum_hazard += hazardScore(packet);
            if (hasMeasurement(packet.visibility_km)) {
                if (!tileAcc.min_visibility_km.has_value()) {
                    tileAcc.min_visibility_km = packet.visibility_km;
                } else {
                    tileAcc.min_visibility_km = std::min(*tileAcc.min_visibility_km, packet.visibility_km);
                }
            }
            if (hasMeasurement(packet.precipitation_mm)) {
                if (!tileAcc.max_precipitation_mm.has_value()) {
                    tileAcc.max_precipitation_mm = packet.precipitation_mm;
                } else {
                    tileAcc.max_precipitation_mm = std::max(*tileAcc.max_precipitation_mm, packet.precipitation_mm);
                }
            }
            if (hasMeasurement(packet.latitude) && hasMeasurement(packet.longitude)) {
                tileAcc.sum_latitude += packet.latitude;
                tileAcc.sum_longitude += packet.longitude;
                tileAcc.geo_count++;
            }

            std::string routeId = envelope.route.empty() ? ("route." + packet.region) : envelope.route;
            std::string segmentId = packet.station_id.empty() ? tileId : packet.station_id;
            auto& routeAcc = routeRiskGroups[{bucket, routeId, segmentId, packet.region}];
            const double currentHazard = hazardScore(packet);
            const double crosswindNorm100 = windNorm(packet) * 100.0;
            const double currentDelayFactor = 1.0 + (0.004 * currentHazard) + (0.002 * crosswindNorm100);
            routeAcc.sample_count++;
            routeAcc.sum_hazard += currentHazard;
            routeAcc.sum_delay_factor += currentDelayFactor;
            if (currentHazard > routeAcc.max_hazard) {
                routeAcc.max_hazard = currentHazard;
                routeAcc.primary_hazard = primaryHazard(packet);
            }
        }

        std::vector<TimescaleAggregateRow> aggregateRows;
        aggregateRows.reserve(aggregateGroups.size());

        for (auto& entry : aggregateGroups) {
            const auto& key = entry.first;
            const auto& packets = entry.second;
            if (packets.empty()) {
                continue;
            }

            double minTemp = packets.front().temperature;
            double maxTemp = packets.front().temperature;
            double sumTemp = 0.0;
            double sumHumidity = 0.0;
            double sumWind = 0.0;

            for (const auto& packet : packets) {
                minTemp = std::min(minTemp, packet.temperature);
                maxTemp = std::max(maxTemp, packet.temperature);
                sumTemp += packet.temperature;
                sumHumidity += packet.humidity;
                sumWind += packet.wind_speed;
            }

            aggregateRows.push_back({
                std::get<0>(key),
                std::get<1>(key),
                std::get<2>(key),
                std::get<3>(key),
                std::get<4>(key),
                packets.size(),
                minTemp,
                maxTemp,
                sumTemp / static_cast<double>(packets.size()),
                sumHumidity / static_cast<double>(packets.size()),
                sumWind / static_cast<double>(packets.size())
            });
        }

        std::vector<TimescaleTileAggregateRow> tileAggregateRows;
        tileAggregateRows.reserve(tileAggregateGroups.size());
        for (const auto& entry : tileAggregateGroups) {
            const auto& key = entry.first;
            const auto& acc = entry.second;
            if (acc.sample_count == 0) {
                continue;
            }

            tileAggregateRows.push_back({
                std::get<0>(key),
                std::get<1>(key),
                std::get<2>(key),
                std::get<3>(key),
                std::get<4>(key),
                acc.sample_count,
                acc.geo_count > 0 ? std::optional<double>(acc.sum_latitude / static_cast<double>(acc.geo_count)) : std::nullopt,
                acc.geo_count > 0 ? std::optional<double>(acc.sum_longitude / static_cast<double>(acc.geo_count)) : std::nullopt,
                acc.sum_temperature / static_cast<double>(acc.sample_count),
                acc.sum_humidity / static_cast<double>(acc.sample_count),
                acc.cloud_count > 0 ? std::optional<double>(acc.sum_cloud_cover / static_cast<double>(acc.cloud_count)) : std::nullopt,
                acc.sum_wind / static_cast<double>(acc.sample_count),
                acc.pressure_count > 0 ? std::optional<double>(acc.sum_pressure / static_cast<double>(acc.pressure_count)) : std::nullopt,
                acc.min_visibility_km,
                acc.max_precipitation_mm,
                acc.sum_hazard / static_cast<double>(acc.sample_count)
            });
        }

        std::vector<TimescaleRouteRiskRow> routeRiskRows;
        routeRiskRows.reserve(routeRiskGroups.size());
        for (const auto& entry : routeRiskGroups) {
            const auto& key = entry.first;
            const auto& acc = entry.second;
            if (acc.sample_count == 0) {
                continue;
            }

            routeRiskRows.push_back({
                std::get<0>(key),
                std::get<1>(key),
                std::get<2>(key),
                std::get<3>(key),
                acc.sum_hazard / static_cast<double>(acc.sample_count),
                acc.sum_delay_factor / static_cast<double>(acc.sample_count),
                acc.primary_hazard
            });
        }

        const std::string batchSql = buildBatchSql(rawRows, aggregateRows, tileAggregateRows, routeRiskRows);

        if (timescaleDb_.executeBatch(batchSql)) {
            std::cout << "[TimescaleWriter] Flushed to TimescaleDB raw=" << rawRows.size()
                      << " aggregate=" << aggregateRows.size()
                      << " tile=" << tileAggregateRows.size()
                      << " route=" << routeRiskRows.size() << std::endl;
            metrics::inc_db_writes();
            return;
        }

        std::ofstream outbox(outboxPath_, std::ios::app);
        if (!outbox.is_open()) {
            std::cerr << "[TimescaleWriter] Failed to open outbox file " << outboxPath_ << std::endl;
            return;
        }

        outbox << batchSql << std::endl;
        std::cout << "[TimescaleWriter] Flushed to outbox raw=" << rawRows.size()
                  << " aggregate=" << aggregateRows.size()
                  << " tile=" << tileAggregateRows.size()
                  << " route=" << routeRiskRows.size() << std::endl;
        metrics::inc_write_errors();
    }

    void replayOutboxIfPresent() {
        namespace fs = std::filesystem;
        if (!fs::exists(outboxPath_)) {
            return;
        }

        std::ifstream input(outboxPath_);
        if (!input.is_open()) {
            return;
        }

        std::ostringstream buffer;
        buffer << input.rdbuf();
        const std::string sql = buffer.str();
        if (sql.empty()) {
            return;
        }

        std::cout << "[TimescaleWriter] Replaying outbox file " << outboxPath_ << std::endl;
        if (timescaleDb_.executeBatch(sql)) {
            std::ofstream truncate(outboxPath_, std::ios::trunc);
            if (truncate.is_open()) {
                std::cout << "[TimescaleWriter] Outbox replay successful" << std::endl;
            } else {
                std::cerr << "[TimescaleWriter] Outbox replay succeeded but truncation failed" << std::endl;
            }
        } else {
            std::cerr << "[TimescaleWriter] Outbox replay failed; leaving file intact" << std::endl;
        }
    }

    std::string buildBatchSql(const std::vector<TimescaleRawRow>& rawRows,
                             const std::vector<TimescaleAggregateRow>& aggregateRows,
                             const std::vector<TimescaleTileAggregateRow>& tileAggregateRows,
                             const std::vector<TimescaleRouteRiskRow>& routeRiskRows) {
        std::ostringstream sql;
        sql << "-- batch " << std::chrono::system_clock::now().time_since_epoch().count() << std::endl;
        sql << "BEGIN;" << std::endl;

        for (const auto& row : rawRows) {
            sql << "INSERT INTO weather_observations_raw "
                << "(message_id, source, continent, country, region, city, event_time, created_at, latitude, longitude, temperature, humidity, wind_speed, visibility_km, precipitation_mm, pressure_hpa, cloud_cover_percent, station_id, ingest_layer, sample_point, payload_json) VALUES ("
                << "'" << escapeSqlLiteral(row.message_id) << "', '"
                << escapeSqlLiteral(row.source) << "', '"
                << escapeSqlLiteral(row.continent) << "', '"
                << escapeSqlLiteral(row.country) << "', '"
                << escapeSqlLiteral(row.region) << "', '"
                << escapeSqlLiteral(row.city) << "', to_timestamp(" << row.event_time << " / 1000.0), to_timestamp(" << row.created_at << " / 1000.0), "
                << sqlNullableDouble(row.latitude) << ", "
                << sqlNullableDouble(row.longitude) << ", "
                << row.temperature << ", " << row.humidity << ", " << row.wind_speed << ", "
                << sqlNullableDouble(row.visibility_km) << ", "
                << sqlNullableDouble(row.precipitation_mm) << ", "
                << sqlNullableDouble(row.pressure_hpa) << ", "
                << sqlNullableDouble(row.cloud_cover_percent) << ", '"
                << escapeSqlLiteral(row.station_id) << "', '"
                << escapeSqlLiteral(row.ingest_layer) << "', '"
                << escapeSqlLiteral(row.sample_point) << "', '"
                << escapeSqlLiteral(row.payload_json) << "') ON CONFLICT (message_id) DO NOTHING;" << std::endl;
        }

        for (const auto& row : aggregateRows) {
            sql << "INSERT INTO weather_city_minute_aggregates "
                << "(bucket_start, continent, country, region, city, observation_count, min_temperature, max_temperature, avg_temperature, avg_humidity, avg_wind_speed) VALUES ("
                << "to_timestamp(" << row.bucket_start << " / 1000.0), '"
                << escapeSqlLiteral(row.continent) << "', '"
                << escapeSqlLiteral(row.country) << "', '"
                << escapeSqlLiteral(row.region) << "', '"
                << escapeSqlLiteral(row.city) << "', "
                << row.observation_count << ", "
                << row.min_temperature << ", "
                << row.max_temperature << ", "
                << row.avg_temperature << ", "
                << row.avg_humidity << ", "
                << row.avg_wind_speed << ") ON CONFLICT (bucket_start, continent, country, region, city) DO UPDATE SET "
                << "observation_count = EXCLUDED.observation_count, "
                << "min_temperature = LEAST(weather_city_minute_aggregates.min_temperature, EXCLUDED.min_temperature), "
                << "max_temperature = GREATEST(weather_city_minute_aggregates.max_temperature, EXCLUDED.max_temperature), "
                << "avg_temperature = EXCLUDED.avg_temperature, "
                << "avg_humidity = EXCLUDED.avg_humidity, "
                << "avg_wind_speed = EXCLUDED.avg_wind_speed;" << std::endl;
        }

        for (const auto& row : tileAggregateRows) {
            sql << "INSERT INTO weather_tile_minute_aggregates "
                << "(bucket_start, tile_id, continent, country, region, latitude, longitude, sample_count, avg_temperature, avg_humidity, avg_cloud_cover, avg_wind_speed, avg_pressure_hpa, min_visibility_km, max_precipitation_mm, hazard_score) VALUES ("
                << "to_timestamp(" << row.bucket_start << " / 1000.0), '"
                << escapeSqlLiteral(row.tile_id) << "', '"
                << escapeSqlLiteral(row.continent) << "', '"
                << escapeSqlLiteral(row.country) << "', '"
                << escapeSqlLiteral(row.region) << "', "
                << (row.latitude.has_value() ? std::to_string(*row.latitude) : std::string("NULL")) << ", "
                << (row.longitude.has_value() ? std::to_string(*row.longitude) : std::string("NULL")) << ", "
                << row.sample_count << ", "
                << row.avg_temperature << ", "
                << row.avg_humidity << ", ";
            if (row.avg_cloud_cover.has_value()) {
                sql << *row.avg_cloud_cover;
            } else {
                sql << "NULL";
            }
            sql << ", " << row.avg_wind_speed << ", ";
            if (row.avg_pressure_hpa.has_value()) {
                sql << *row.avg_pressure_hpa;
            } else {
                sql << "NULL";
            }
            sql << ", ";
            if (row.min_visibility_km.has_value()) {
                sql << *row.min_visibility_km;
            } else {
                sql << "NULL";
            }
            sql << ", ";
            if (row.max_precipitation_mm.has_value()) {
                sql << *row.max_precipitation_mm;
            } else {
                sql << "NULL";
            }
            sql << ", " << row.hazard_score
                << ") ON CONFLICT (bucket_start, tile_id, region) DO UPDATE SET "
                << "sample_count = EXCLUDED.sample_count, "
                << "avg_temperature = EXCLUDED.avg_temperature, "
                << "latitude = EXCLUDED.latitude, "
                << "longitude = EXCLUDED.longitude, "
                << "avg_humidity = EXCLUDED.avg_humidity, "
                << "avg_cloud_cover = EXCLUDED.avg_cloud_cover, "
                << "avg_wind_speed = EXCLUDED.avg_wind_speed, "
                << "avg_pressure_hpa = EXCLUDED.avg_pressure_hpa, "
                << "min_visibility_km = LEAST(weather_tile_minute_aggregates.min_visibility_km, EXCLUDED.min_visibility_km), "
                << "max_precipitation_mm = GREATEST(weather_tile_minute_aggregates.max_precipitation_mm, EXCLUDED.max_precipitation_mm), "
                << "hazard_score = EXCLUDED.hazard_score;" << std::endl;
        }

        for (const auto& row : routeRiskRows) {
            sql << "INSERT INTO route_segment_risk_minute "
                << "(bucket_start, route_id, segment_id, region, hazard_score, delay_factor, primary_hazard) VALUES ("
                << "to_timestamp(" << row.bucket_start << " / 1000.0), '"
                << escapeSqlLiteral(row.route_id) << "', '"
                << escapeSqlLiteral(row.segment_id) << "', '"
                << escapeSqlLiteral(row.region) << "', "
                << row.hazard_score << ", "
                << row.delay_factor << ", '"
                << escapeSqlLiteral(row.primary_hazard)
                << "') ON CONFLICT (bucket_start, route_id, segment_id) DO UPDATE SET "
                << "hazard_score = EXCLUDED.hazard_score, "
                << "delay_factor = EXCLUDED.delay_factor, "
                << "primary_hazard = EXCLUDED.primary_hazard;" << std::endl;
        }

        sql << "COMMIT;" << std::endl;
        return sql.str();
    }

    std::string outboxPath_;
    std::size_t maxQueueSize_;
    std::size_t batchSize_;
    std::chrono::milliseconds flushInterval_;
    std::deque<MessageEnvelope> pending_;
    std::unordered_set<std::string> seenIds_;
    std::deque<std::string> idOrder_;
    std::mutex mutex_;
    std::condition_variable cv_;
    TimescaleDbClient timescaleDb_;
};
