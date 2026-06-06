#pragma once

#include <cmath>
#include <limits>
#include <string>

#include <nlohmann/json.hpp>

#include "../models/WeatherPacket.hpp"
#include "../protocol/MessageEnvelope.hpp"

using json = nlohmann::json;

struct MapTileHazardEvent {
    std::string source_message_id;
    std::string region;
    std::string country;
    std::string continent;
    std::string city;
    std::string tile_id;
    std::string primary_hazard;
    long bucket_start;
    double hazard_score;
    double latitude;
    double longitude;
};

struct MapRouteRiskEvent {
    std::string source_message_id;
    std::string route_id;
    std::string segment_id;
    std::string region;
    std::string primary_hazard;
    long bucket_start;
    double hazard_score;
    double delay_factor;
};

inline bool map_has_measurement(double value) {
    return !std::isnan(value);
}

inline double map_clamp01(double value) {
    return std::max(0.0, std::min(1.0, value));
}

inline std::string map_tile_id_from_packet(const WeatherPacket& packet) {
    if (!map_has_measurement(packet.latitude) || !map_has_measurement(packet.longitude)) {
        return packet.region + ":" + packet.city;
    }

    // 1/32-degree buckets are a better fit for city-area logistics than coarse regional tiles.
    const int latBucket = static_cast<int>(std::floor((packet.latitude + 90.0) * 32.0));
    const int lonBucket = static_cast<int>(std::floor((packet.longitude + 180.0) * 32.0));
    return "q25:" + std::to_string(latBucket) + ":" + std::to_string(lonBucket);
}

inline double map_wind_norm(const WeatherPacket& packet) {
    return map_clamp01(packet.wind_speed / 80.0);
}

inline double map_precip_norm(const WeatherPacket& packet) {
    if (!map_has_measurement(packet.precipitation_mm)) {
        return 0.0;
    }
    return map_clamp01(packet.precipitation_mm / 25.0);
}

inline double map_visibility_norm(const WeatherPacket& packet) {
    if (!map_has_measurement(packet.visibility_km)) {
        return 0.0;
    }
    return map_clamp01((10.0 - packet.visibility_km) / 10.0);
}

inline double map_heat_norm(const WeatherPacket& packet) {
    if (packet.temperature >= 15.0 && packet.temperature <= 30.0) {
        return 0.0;
    }

    const double distance = packet.temperature < 15.0 ? (15.0 - packet.temperature)
                                                      : (packet.temperature - 30.0);
    return map_clamp01(distance / 20.0);
}

inline double map_tile_hazard_score(const WeatherPacket& packet) {
    const double score01 = 0.35 * map_wind_norm(packet) +
                           0.30 * map_precip_norm(packet) +
                           0.20 * map_visibility_norm(packet) +
                           0.15 * map_heat_norm(packet);
    return score01 * 100.0;
}

inline double map_route_delay_factor(const WeatherPacket& packet) {
    const double hazard = map_tile_hazard_score(packet);
    const double crosswindNorm100 = map_wind_norm(packet) * 100.0;
    return 1.0 + (0.004 * hazard) + (0.002 * crosswindNorm100);
}

inline std::string map_primary_hazard(const WeatherPacket& packet) {
    const double wind = map_wind_norm(packet);
    const double precip = map_precip_norm(packet);
    const double vis = map_visibility_norm(packet);
    const double heat = map_heat_norm(packet);

    if (wind >= precip && wind >= vis && wind >= heat) {
        return "wind";
    }
    if (precip >= wind && precip >= vis && precip >= heat) {
        return "precipitation";
    }
    if (vis >= wind && vis >= precip && vis >= heat) {
        return "visibility";
    }
    return "temperature";
}

inline long map_minute_bucket(long timestampMs) {
    return (timestampMs / 60000L) * 60000L;
}

inline MapTileHazardEvent make_map_tile_hazard_event(const MessageEnvelope& envelope,
                                                     const WeatherPacket& packet) {
    const long bucketStart = map_minute_bucket(packet.timestamp);
    return {
        envelope.message_id,
        packet.region,
        packet.country,
        packet.continent,
        packet.city,
        map_tile_id_from_packet(packet),
        map_primary_hazard(packet),
        bucketStart,
        map_tile_hazard_score(packet),
        packet.latitude,
        packet.longitude
    };
}

inline MapRouteRiskEvent make_map_route_risk_event(const MessageEnvelope& envelope,
                                                   const WeatherPacket& packet) {
    const std::string routeId = envelope.route.empty() ? ("route." + packet.region) : envelope.route;
    const std::string segmentId = packet.station_id.empty() ? map_tile_id_from_packet(packet) : packet.station_id;
    const double hazard = map_tile_hazard_score(packet);
    return {
        envelope.message_id,
        routeId,
        segmentId,
        packet.region,
        map_primary_hazard(packet),
        map_minute_bucket(packet.timestamp),
        hazard,
        map_route_delay_factor(packet)
    };
}

inline json to_json(const MapTileHazardEvent& event) {
    json payload = {
        {"source_message_id", event.source_message_id},
        {"continent", event.continent},
        {"country", event.country},
        {"region", event.region},
        {"city", event.city},
        {"tile_id", event.tile_id},
        {"primary_hazard", event.primary_hazard},
        {"bucket_start", event.bucket_start},
        {"hazard_score", event.hazard_score}
    };

    if (!std::isnan(event.latitude)) {
        payload["latitude"] = event.latitude;
    }
    if (!std::isnan(event.longitude)) {
        payload["longitude"] = event.longitude;
    }

    return payload;
}

inline json to_json(const MapRouteRiskEvent& event) {
    return {
        {"source_message_id", event.source_message_id},
        {"route_id", event.route_id},
        {"segment_id", event.segment_id},
        {"region", event.region},
        {"primary_hazard", event.primary_hazard},
        {"bucket_start", event.bucket_start},
        {"hazard_score", event.hazard_score},
        {"delay_factor", event.delay_factor}
    };
}
