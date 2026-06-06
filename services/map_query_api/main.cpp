#include <algorithm>
#include <atomic>
#include <cctype>
#include <chrono>
#include <csignal>
#include <cstring>
#include <cmath>
#include <iostream>
#include <map>
#include <optional>
#include <sstream>
#include <string>
#include <thread>
#include <utility>
#include <vector>

#include <nlohmann/json.hpp>
#include <poll.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <unistd.h>

#include <cstdint>

#include "../../common/analytics/MapAnalytics.hpp"
#include "../../common/timescale/TimescaleReadClient.hpp"

using json = nlohmann::json;

namespace {
std::atomic<bool> running{true};

void handleShutdownSignal(int) {
    running.store(false);
}

struct HttpRequest {
    std::string method;
    std::string path;
    std::map<std::string, std::string> query;
    json body;
};

struct TileSnapshot {
    std::string tile_id;
    std::string region;
    std::string continent;
    std::string country;
    double latitude;
    double longitude;
    double hazard_score;
    std::string primary_hazard;
    long bucket_start;
};

struct RouteSegmentSnapshot {
    std::string route_id;
    std::string segment_id;
    std::string region;
    double hazard_score;
    double delay_factor;
    std::string primary_hazard;
    long bucket_start;
};

using RoutePolyline = std::vector<std::pair<double, double>>;

struct CityCoordinate {
    double latitude;
    double longitude;
};

struct TileBounds {
    double minLatitude;
    double minLongitude;
    double maxLatitude;
    double maxLongitude;
};

constexpr int kTileSize = 256;

std::string resolveTopologyPath() {
    const std::vector<std::string> candidates = {
        "configs/global_topology.json",
        "../configs/global_topology.json"
    };

    for (const auto& candidate : candidates) {
        std::ifstream file(candidate);
        if (file.is_open()) {
            return candidate;
        }
    }

    return "configs/global_topology.json";
}

std::map<std::string, CityCoordinate> loadCityCoordinates() {
    std::map<std::string, CityCoordinate> coordinates;
    std::ifstream topologyFile(resolveTopologyPath());
    if (!topologyFile.is_open()) {
        return coordinates;
    }

    auto parseNumber = [](const json& value, double fallback) {
        if (value.is_number()) {
            return value.get<double>();
        }
        if (value.is_string()) {
            try {
                return std::stod(value.get<std::string>());
            } catch (...) {
                return fallback;
            }
        }
        return fallback;
    };

    try {
        json topology = json::parse(topologyFile);
        if (!topology.contains("topology") || !topology["topology"].contains("regions")) {
            return coordinates;
        }

        for (const auto& region : topology["topology"]["regions"]) {
            const std::string regionName = region.value("name", "");
            if (!region.contains("cities") || !region["cities"].is_array()) {
                continue;
            }

            for (const auto& city : region["cities"]) {
                if (!city.contains("name") || !city.contains("latitude") || !city.contains("longitude")) {
                    continue;
                }

                const std::string cityName = city.value("name", "");
                const double latitude = city.contains("latitude") ? parseNumber(city.at("latitude"), 0.0) : 0.0;
                const double longitude = city.contains("longitude") ? parseNumber(city.at("longitude"), 0.0) : 0.0;
                coordinates[regionName + ":" + cityName] = CityCoordinate{
                    latitude,
                    longitude
                };
            }
        }
    } catch (...) {
        return {};
    }

    return coordinates;
}

std::optional<CityCoordinate> resolveTileCoordinate(const json& row,
                                                    const std::map<std::string, CityCoordinate>& cityCoordinates) {
    if (row.contains("latitude") && row.contains("longitude") && row["latitude"].is_number() && row["longitude"].is_number()) {
        return CityCoordinate{row["latitude"].get<double>(), row["longitude"].get<double>()};
    }

    const std::string tileId = row.value("tile_id", "");
    const std::string region = row.value("region", "");

    if (tileId.find(':') != std::string::npos) {
        const std::size_t separator = tileId.find(':');
        const std::string cityName = tileId.substr(separator + 1);

        const std::string regionKey = region.empty() ? tileId.substr(0, separator) : region;
        const std::string lookupKey = regionKey + ":" + cityName;
        if (auto it = cityCoordinates.find(lookupKey); it != cityCoordinates.end()) {
            return it->second;
        }
    }

    return std::nullopt;
}

double jsonNumberOr(const json& row, const char* key, double fallback) {
    if (!row.contains(key) || row.at(key).is_null()) {
        return fallback;
    }

    if (row.at(key).is_number()) {
        return row.at(key).get<double>();
    }

    if (row.at(key).is_string()) {
        try {
            return std::stod(row.at(key).get<std::string>());
        } catch (...) {
            return fallback;
        }
    }

    return fallback;
}

bool pointInBounds(double latitude,
                   double longitude,
                   const std::optional<double>& minLat,
                   const std::optional<double>& minLon,
                   const std::optional<double>& maxLat,
                   const std::optional<double>& maxLon) {
    if (minLat.has_value() && latitude < *minLat) {
        return false;
    }
    if (maxLat.has_value() && latitude > *maxLat) {
        return false;
    }
    if (minLon.has_value() && longitude < *minLon) {
        return false;
    }
    if (maxLon.has_value() && longitude > *maxLon) {
        return false;
    }
    return true;
}

TileBounds tileBounds(int z, int x, int y) {
    const double n = std::pow(2.0, static_cast<double>(z));
    const auto tileYToLat = [n](int tileY) {
        const double latRad = std::atan(std::sinh(M_PI * (1.0 - (2.0 * static_cast<double>(tileY)) / n)));
        return latRad * 180.0 / M_PI;
    };

    return {
        tileYToLat(y + 1),
        (static_cast<double>(x) / n) * 360.0 - 180.0,
        tileYToLat(y),
        ((static_cast<double>(x) + 1.0) / n) * 360.0 - 180.0,
    };
}

double clamp01(double value) {
    return std::max(0.0, std::min(1.0, value));
}

double heatIntensity(const std::string& layer, double value) {
    if (layer == "visibility") {
        return std::max(0.08, std::min(1.0, 1.0 - std::min(value, 20.0) / 20.0));
    }
    if (layer == "precipitation") {
        return std::max(0.08, std::min(1.0, value / 50.0));
    }
    if (layer == "wind") {
        return std::max(0.08, std::min(1.0, value / 100.0));
    }
    if (layer == "cloud") {
        return std::max(0.08, std::min(1.0, value / 100.0));
    }
    if (layer == "pressure") {
        return std::max(0.08, std::min(1.0, std::abs(value - 1013.0) / 50.0));
    }

    return std::max(0.08, std::min(1.0, value / 100.0));
}

std::pair<double, double> mercatorPixel(const CityCoordinate& coordinate, int z) {
    const double n = std::pow(2.0, static_cast<double>(z));
    const double latRad = coordinate.latitude * M_PI / 180.0;
    const double x = (coordinate.longitude + 180.0) / 360.0 * n * kTileSize;
    const double y = (1.0 - std::log(std::tan(latRad) + (1.0 / std::cos(latRad))) / M_PI) / 2.0 * n * kTileSize;
    return {x, y};
}

std::vector<unsigned char> encodePngRgba(int width, int height, const std::vector<unsigned char>& rgba) {
    auto appendUint32 = [](std::vector<unsigned char>& out, std::uint32_t value) {
        out.push_back(static_cast<unsigned char>((value >> 24) & 0xff));
        out.push_back(static_cast<unsigned char>((value >> 16) & 0xff));
        out.push_back(static_cast<unsigned char>((value >> 8) & 0xff));
        out.push_back(static_cast<unsigned char>(value & 0xff));
    };

    auto crc32 = [](const unsigned char* data, std::size_t length) {
        static std::uint32_t table[256];
        static bool initialized = false;
        if (!initialized) {
            for (std::uint32_t index = 0; index < 256; ++index) {
                std::uint32_t crc = index;
                for (int bit = 0; bit < 8; ++bit) {
                    if (crc & 1U) {
                        crc = 0xedb88320U ^ (crc >> 1U);
                    } else {
                        crc >>= 1U;
                    }
                }
                table[index] = crc;
            }
            initialized = true;
        }

        std::uint32_t crc = 0xffffffffU;
        for (std::size_t index = 0; index < length; ++index) {
            const unsigned char byte = data[index];
            crc = table[(crc ^ byte) & 0xffU] ^ (crc >> 8U);
        }
        return crc ^ 0xffffffffU;
    };

    auto adler32 = [](const std::vector<unsigned char>& data) {
        constexpr std::uint32_t mod = 65521U;
        std::uint32_t a = 1U;
        std::uint32_t b = 0U;
        for (unsigned char byte : data) {
            a = (a + byte) % mod;
            b = (b + a) % mod;
        }
        return (b << 16U) | a;
    };

    auto appendChunk = [&](std::vector<unsigned char>& out, const char type[4], const std::vector<unsigned char>& data) {
        appendUint32(out, static_cast<std::uint32_t>(data.size()));
        const std::size_t typeOffset = out.size();
        out.push_back(static_cast<unsigned char>(type[0]));
        out.push_back(static_cast<unsigned char>(type[1]));
        out.push_back(static_cast<unsigned char>(type[2]));
        out.push_back(static_cast<unsigned char>(type[3]));
        out.insert(out.end(), data.begin(), data.end());
        const std::uint32_t crc = crc32(out.data() + typeOffset, 4 + data.size());
        appendUint32(out, crc);
    };

    std::vector<unsigned char> png;
    png.insert(png.end(), {0x89, 'P', 'N', 'G', '\r', '\n', 0x1a, '\n'});

    std::vector<unsigned char> ihdr;
    appendUint32(ihdr, static_cast<std::uint32_t>(width));
    appendUint32(ihdr, static_cast<std::uint32_t>(height));
    ihdr.push_back(8);
    ihdr.push_back(6);
    ihdr.push_back(0);
    ihdr.push_back(0);
    ihdr.push_back(0);
    appendChunk(png, "IHDR", ihdr);

    std::vector<unsigned char> raw;
    raw.reserve(static_cast<std::size_t>(height) * (static_cast<std::size_t>(width) * 4 + 1));
    for (int row = 0; row < height; ++row) {
        raw.push_back(0);
        const std::size_t offset = static_cast<std::size_t>(row) * static_cast<std::size_t>(width) * 4;
        raw.insert(raw.end(), rgba.begin() + offset, rgba.begin() + offset + static_cast<std::size_t>(width) * 4);
    }

    std::vector<unsigned char> zlibData;
    zlibData.push_back(0x78);
    zlibData.push_back(0x01);
    std::size_t cursor = 0;
    while (cursor < raw.size()) {
        const std::size_t chunkSize = std::min<std::size_t>(65535, raw.size() - cursor);
        const bool isFinal = (cursor + chunkSize) >= raw.size();
        zlibData.push_back(isFinal ? 0x01 : 0x00);
        const std::uint16_t len = static_cast<std::uint16_t>(chunkSize);
        const std::uint16_t nlen = static_cast<std::uint16_t>(~len);
        zlibData.push_back(static_cast<unsigned char>(len & 0xffU));
        zlibData.push_back(static_cast<unsigned char>((len >> 8U) & 0xffU));
        zlibData.push_back(static_cast<unsigned char>(nlen & 0xffU));
        zlibData.push_back(static_cast<unsigned char>((nlen >> 8U) & 0xffU));
        zlibData.insert(zlibData.end(), raw.begin() + static_cast<std::ptrdiff_t>(cursor), raw.begin() + static_cast<std::ptrdiff_t>(cursor + chunkSize));
        cursor += chunkSize;
    }
    appendUint32(zlibData, adler32(raw));
    appendChunk(png, "IDAT", zlibData);

    appendChunk(png, "IEND", {});
    return png;
}

std::vector<unsigned char> renderHeatTilePng(const std::vector<json>& rows,
                                             const std::map<std::string, CityCoordinate>& cityCoordinates,
                                             const std::string& layer,
                                             int z,
                                             int x,
                                             int y) {
    const TileBounds bounds = tileBounds(z, x, y);
    const double tileOriginX = (static_cast<double>(x) / std::pow(2.0, static_cast<double>(z))) * kTileSize * std::pow(2.0, static_cast<double>(z));
    const double tileOriginY = (static_cast<double>(y) / std::pow(2.0, static_cast<double>(z))) * kTileSize * std::pow(2.0, static_cast<double>(z));

    std::vector<unsigned char> rgba(static_cast<std::size_t>(kTileSize) * kTileSize * 4, 0);
    std::vector<double> accum(static_cast<std::size_t>(kTileSize) * kTileSize, 0.0);
    std::vector<double> weight(static_cast<std::size_t>(kTileSize) * kTileSize, 0.0);

    struct Point {
        double x;
        double y;
        double intensity;
    };

    std::vector<Point> points;
    points.reserve(rows.size());

    for (const auto& row : rows) {
        auto coordinate = resolveTileCoordinate(row, cityCoordinates);
        if (!coordinate.has_value() || !pointInBounds(coordinate->latitude, coordinate->longitude, std::nullopt, std::nullopt, std::nullopt, std::nullopt)) {
            continue;
        }

        const auto [pixelX, pixelY] = mercatorPixel(*coordinate, z);
        const double localX = pixelX - tileOriginX;
        const double localY = pixelY - tileOriginY;
        if (localX < -80.0 || localX > static_cast<double>(kTileSize) + 80.0 || localY < -80.0 || localY > static_cast<double>(kTileSize) + 80.0) {
            continue;
        }

        const double layerValue = jsonNumberOr(row, "layer_value", jsonNumberOr(row, "hazard_score", 0.0));
        points.push_back(Point{localX, localY, heatIntensity(layer, layerValue)});
    }

    if (points.empty()) {
        return encodePngRgba(kTileSize, kTileSize, rgba);
    }

    constexpr double sigma = 28.0;
    constexpr double sigma2 = sigma * sigma;
    constexpr int radius = 84;

    for (const auto& point : points) {
        const int minX = std::max(0, static_cast<int>(std::floor(point.x - radius)));
        const int maxX = std::min(kTileSize - 1, static_cast<int>(std::ceil(point.x + radius)));
        const int minY = std::max(0, static_cast<int>(std::floor(point.y - radius)));
        const int maxY = std::min(kTileSize - 1, static_cast<int>(std::ceil(point.y + radius)));

        for (int py = minY; py <= maxY; ++py) {
            for (int px = minX; px <= maxX; ++px) {
                const double dx = static_cast<double>(px) - point.x;
                const double dy = static_cast<double>(py) - point.y;
                const double distance2 = dx * dx + dy * dy;
                if (distance2 > static_cast<double>(radius * radius)) {
                    continue;
                }

                const double kernel = std::exp(-distance2 / (2.0 * sigma2));
                const std::size_t index = static_cast<std::size_t>(py) * kTileSize + static_cast<std::size_t>(px);
                accum[index] += point.intensity * kernel;
                weight[index] += kernel;
            }
        }
    }

    double maxValue = 0.0;
    std::vector<double> values(static_cast<std::size_t>(kTileSize) * kTileSize, 0.0);
    for (std::size_t index = 0; index < values.size(); ++index) {
        if (weight[index] > 0.0) {
            values[index] = accum[index] / weight[index];
            maxValue = std::max(maxValue, values[index]);
        }
    }

    if (maxValue <= 0.0) {
        return encodePngRgba(kTileSize, kTileSize, rgba);
    }

    for (int py = 0; py < kTileSize; ++py) {
        for (int px = 0; px < kTileSize; ++px) {
            const std::size_t index = static_cast<std::size_t>(py) * kTileSize + static_cast<std::size_t>(px);
            const double normalized = clamp01(values[index] / maxValue);
            if (normalized <= 0.0) {
                continue;
            }

            const double r = normalized;
            const double g = std::min(1.0, normalized * 1.35);
            const double b = 1.0 - normalized;
            const unsigned char alpha = static_cast<unsigned char>(std::round(40.0 + normalized * 200.0));

            const std::size_t offset = index * 4;
            rgba[offset + 0] = static_cast<unsigned char>(std::round(255.0 * r));
            rgba[offset + 1] = static_cast<unsigned char>(std::round(255.0 * g));
            rgba[offset + 2] = static_cast<unsigned char>(std::round(255.0 * b));
            rgba[offset + 3] = alpha;
        }
    }

    return encodePngRgba(kTileSize, kTileSize, rgba);
}

RoutePolyline routePolylineFor(const std::string& routeId) {
    if (routeId == "route.blr_metro") {
        return {
            {12.9716, 77.5946},
            {12.9520, 77.6100},
            {12.9150, 77.6400},
            {12.8800, 77.6750},
        };
    }
    if (routeId == "route.hyd_metro") {
        return {
            {17.3850, 78.4867},
            {17.4100, 78.4550},
            {17.4400, 78.4200},
        };
    }
    if (routeId == "route.europe_west_corridor") {
        return {
            {48.8566, 2.3522},
            {48.9000, 2.5000},
            {48.9800, 2.6500},
        };
    }

    return {};
}

class MapQueryStore {
public:
    MapQueryStore()
        : cityCoordinates_(loadCityCoordinates()) {}

    json tileSnapshot(const std::string& layer,
                      const std::optional<double>& minLat,
                      const std::optional<double>& minLon,
                      const std::optional<double>& maxLat,
                      const std::optional<double>& maxLon,
                      const std::string& asOf = "") const {
        if (auto dbSnapshot = tileSnapshotFromDb(layer, minLat, minLon, maxLat, maxLon); dbSnapshot.has_value()) {
            json snapshot = *dbSnapshot;
            snapshot["as_of"] = asOf;
            return snapshot;
        }

        return fallbackTileSnapshot(layer, minLat, minLon, maxLat, maxLon, asOf);
    }

    json routeRiskSnapshot(const std::string& routeId,
                           const std::vector<std::string>& segmentIds,
                           const std::string& asOf = "") const {
        if (auto dbSnapshot = routeRiskSnapshotFromDb(routeId, segmentIds); dbSnapshot.has_value()) {
            json snapshot = *dbSnapshot;
            snapshot["route_polyline"] = json::array();
            for (const auto& point : routePolylineFor(routeId)) {
                snapshot["route_polyline"].push_back({point.first, point.second});
            }
            snapshot["as_of"] = asOf;
            return snapshot;
        }

        return fallbackRouteRiskSnapshot(routeId, segmentIds, asOf);
    }

    std::optional<std::vector<unsigned char>> renderTilePng(const std::string& layer,
                                                            int z,
                                                            int x,
                                                            int y,
                                                            const std::string& asOf = "") const {
        if (!readClient_.isEnabled()) {
            return std::nullopt;
        }

        std::string layerExpr = "hazard_score";
        if (layer == "temperature") {
            layerExpr = "avg_temperature";
        } else if (layer == "wind") {
            layerExpr = "avg_wind_speed";
        } else if (layer == "pressure") {
            layerExpr = "avg_pressure_hpa";
        } else if (layer == "cloud") {
            layerExpr = "avg_cloud_cover";
        } else if (layer == "visibility") {
            layerExpr = "min_visibility_km";
        } else if (layer == "precipitation") {
            layerExpr = "max_precipitation_mm";
        }

        std::ostringstream sql;
        sql << "WITH latest AS (SELECT max(bucket_start) AS bucket_start FROM weather_tile_minute_aggregates) ";
        sql << "SELECT COALESCE(json_agg(row_to_json(tile_rows)), '[]'::json)::text FROM (";
        sql << " SELECT tile_id, region, continent, country, latitude, longitude, hazard_score, bucket_start, ";
        sql << layerExpr << " AS layer_value";
        sql << " FROM weather_tile_minute_aggregates WHERE bucket_start = (SELECT bucket_start FROM latest)";
        sql << " ORDER BY hazard_score DESC, tile_id ASC LIMIT 500) tile_rows;";

        auto response = readClient_.queryJson(sql.str());
        if (!response.has_value() || !response->is_array()) {
            return std::nullopt;
        }

        std::vector<json> rows;
        rows.reserve(response->size());
        for (const auto& row : *response) {
            rows.push_back(row);
        }

        return renderHeatTilePng(rows, cityCoordinates_, layer, z, x, y);
    }

    public:
    static std::string sqlEscape(const std::string& value) {
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

    static std::string sqlOptionalBounds(const std::optional<double>& minLat,
                                         const std::optional<double>& minLon,
                                         const std::optional<double>& maxLat,
                                         const std::optional<double>& maxLon) {
        std::ostringstream sql;
        sql << "WITH latest AS (SELECT max(bucket_start) AS bucket_start FROM weather_tile_minute_aggregates) ";
        sql << "SELECT COALESCE(json_agg(row_to_json(tile_rows)), '[]'::json)::text FROM (";
        sql << " SELECT tile_id, region, continent, country, latitude, longitude, hazard_score, bucket_start, ";
        sql << " CASE "
            << " WHEN '" << "" << "' = 'wind' THEN avg_wind_speed"
            << " WHEN '" << "" << "' = 'visibility' THEN COALESCE(min_visibility_km, 0)"
            << " WHEN '" << "" << "' = 'precipitation' THEN COALESCE(max_precipitation_mm, 0)"
            << " ELSE hazard_score END AS layer_value";
        sql << " FROM weather_tile_minute_aggregates WHERE bucket_start = (SELECT bucket_start FROM latest)";
        sql << " AND latitude IS NOT NULL AND longitude IS NOT NULL";

        if (minLat.has_value()) {
            sql << " AND latitude >= " << *minLat;
        }
        if (maxLat.has_value()) {
            sql << " AND latitude <= " << *maxLat;
        }
        if (minLon.has_value()) {
            sql << " AND longitude >= " << *minLon;
        }
        if (maxLon.has_value()) {
            sql << " AND longitude <= " << *maxLon;
        }

        sql << " ORDER BY hazard_score DESC, tile_id ASC LIMIT 100) tile_rows";
        return sql.str();
    }

    std::optional<json> tileSnapshotFromDb(const std::string& layer,
                                           const std::optional<double>& minLat,
                                           const std::optional<double>& minLon,
                                           const std::optional<double>& maxLat,
                                           const std::optional<double>& maxLon) const {
        if (!readClient_.isEnabled()) {
            return std::nullopt;
        }

        std::ostringstream sql;
        sql << "WITH latest AS (SELECT max(bucket_start) AS bucket_start FROM weather_tile_minute_aggregates) ";
        sql << "SELECT COALESCE(json_agg(row_to_json(tile_rows)), '[]'::json)::text FROM (";
        sql << " SELECT tile_id, region, continent, country, latitude, longitude, hazard_score, primary_hazard, bucket_start, ";
        if (layer == "temperature") {
            sql << "avg_temperature AS layer_value";
        } else if (layer == "wind") {
            sql << "avg_wind_speed AS layer_value";
        } else if (layer == "pressure") {
            sql << "COALESCE(avg_pressure_hpa, 0) AS layer_value";
        } else if (layer == "cloud") {
            sql << "COALESCE(avg_cloud_cover, 0) AS layer_value";
        } else if (layer == "visibility") {
            sql << "COALESCE(min_visibility_km, 0) AS layer_value";
        } else if (layer == "precipitation") {
            sql << "COALESCE(max_precipitation_mm, 0) AS layer_value";
        } else {
            sql << "hazard_score AS layer_value";
        }
        sql << " FROM weather_tile_minute_aggregates WHERE bucket_start = (SELECT bucket_start FROM latest)";
        sql << " AND latitude IS NOT NULL AND longitude IS NOT NULL";

        if (minLat.has_value()) {
            sql << " AND latitude >= " << *minLat;
        }
        if (maxLat.has_value()) {
            sql << " AND latitude <= " << *maxLat;
        }
        if (minLon.has_value()) {
            sql << " AND longitude >= " << *minLon;
        }
        if (maxLon.has_value()) {
            sql << " AND longitude <= " << *maxLon;
        }

        sql << " ORDER BY hazard_score DESC, tile_id ASC LIMIT 100) tile_rows;";

        auto response = readClient_.queryJson(sql.str());
        if (!response.has_value() || !response->is_array()) {
            return std::nullopt;
        }

        json tiles = json::array();
        for (const auto& row : *response) {
            tiles.push_back({
                {"tile_id", row.value("tile_id", "")},
                {"region", row.value("region", "")},
                {"continent", row.value("continent", "")},
                {"country", row.value("country", "")},
                {"latitude", jsonNumberOr(row, "latitude", 0.0)},
                {"longitude", jsonNumberOr(row, "longitude", 0.0)},
                {"hazard_score", jsonNumberOr(row, "hazard_score", 0.0)},
                {"layer_value", jsonNumberOr(row, "layer_value", 0.0)},
                {"avg_cloud_cover", row.contains("avg_cloud_cover") ? row.value("avg_cloud_cover", nullptr) : nullptr},
                {"avg_pressure_hpa", row.contains("avg_pressure_hpa") ? row.value("avg_pressure_hpa", nullptr) : nullptr},
                {"primary_hazard", "unknown"},
                {"bucket_start", row.value("bucket_start", "")},
                {"layer", layer}
            });
        }

        return json{
            {"layer", layer},
            {"count", tiles.size()},
            {"tiles", tiles},
            {"source", "timescale"}
        };
    }

    std::optional<json> routeRiskSnapshotFromDb(const std::string& routeId,
                                                const std::vector<std::string>& segmentIds) const {
        if (!readClient_.isEnabled()) {
            return std::nullopt;
        }

        std::ostringstream sql;
        sql << "WITH latest AS (SELECT max(bucket_start) AS bucket_start FROM route_segment_risk_minute) ";
        sql << "SELECT COALESCE(json_agg(row_to_json(route_rows)), '[]'::json)::text FROM (";
        sql << " SELECT route_id, segment_id, region, hazard_score, delay_factor, primary_hazard, bucket_start "
            << " FROM route_segment_risk_minute WHERE bucket_start = (SELECT bucket_start FROM latest)";
        sql << " AND route_id = '" << sqlEscape(routeId) << "'";

        if (!segmentIds.empty()) {
            sql << " AND segment_id IN (";
            for (std::size_t index = 0; index < segmentIds.size(); ++index) {
                if (index > 0) {
                    sql << ", ";
                }
                sql << "'" << sqlEscape(segmentIds[index]) << "'";
            }
            sql << ")";
        }

        sql << " ORDER BY segment_id ASC) route_rows;";

        auto response = readClient_.queryJson(sql.str());
        if (!response.has_value() || !response->is_array()) {
            return std::nullopt;
        }

        json segments = json::array();
        double hazardSum = 0.0;
        double delaySum = 0.0;
        for (const auto& row : *response) {
            const double hazard = jsonNumberOr(row, "hazard_score", 0.0);
            const double delayFactor = jsonNumberOr(row, "delay_factor", 1.0);
            hazardSum += hazard;
            delaySum += delayFactor;
            segments.push_back({
                {"segment_id", row.value("segment_id", "")},
                {"region", row.value("region", "")},
                {"hazard_score", hazard},
                {"delay_factor", delayFactor},
                {"primary_hazard", row.value("primary_hazard", "unknown")},
                {"bucket_start", row.value("bucket_start", "")}
            });
        }

        const std::size_t count = std::max<std::size_t>(1, segments.size());
        return json{
            {"route_id", routeId},
            {"segment_count", segments.size()},
            {"route_hazard_score", hazardSum / static_cast<double>(count)},
            {"route_delay_factor", delaySum / static_cast<double>(count)},
            {"projected_eta_delta_minutes", (delaySum / static_cast<double>(count) - 1.0) * 60.0},
            {"segments", segments},
            {"source", "timescale"}
        };
    }

    std::optional<json> mapSummaryFromDb(const std::string& layer,
                                         const std::optional<double>& minLat,
                                         const std::optional<double>& minLon,
                                         const std::optional<double>& maxLat,
                                         const std::optional<double>& maxLon,
                                         const std::string& asOf) const {
        if (!readClient_.isEnabled()) {
            return std::nullopt;
        }

        std::string layerExpr = "hazard_score";
        if (layer == "temperature") {
            layerExpr = "avg_temperature";
        } else if (layer == "wind") {
            layerExpr = "avg_wind_speed";
        } else if (layer == "pressure") {
            layerExpr = "avg_pressure_hpa";
        } else if (layer == "cloud") {
            layerExpr = "avg_cloud_cover";
        } else if (layer == "visibility") {
            layerExpr = "min_visibility_km";
        } else if (layer == "precipitation") {
            layerExpr = "max_precipitation_mm";
        }

        std::ostringstream sql;
        sql << "WITH latest AS (SELECT max(bucket_start) AS bucket_start FROM weather_tile_minute_aggregates), filtered AS (";
        sql << " SELECT * FROM weather_tile_minute_aggregates WHERE bucket_start = (SELECT bucket_start FROM latest)";
        sql << " AND latitude IS NOT NULL AND longitude IS NOT NULL";

        if (minLat.has_value()) {
            sql << " AND latitude >= " << *minLat;
        }
        if (maxLat.has_value()) {
            sql << " AND latitude <= " << *maxLat;
        }
        if (minLon.has_value()) {
            sql << " AND longitude >= " << *minLon;
        }
        if (maxLon.has_value()) {
            sql << " AND longitude <= " << *maxLon;
        }

        sql << ") SELECT json_build_object(";
        sql << "'layer', '" << sqlEscape(layer) << "',";
        sql << "'tile_count', COALESCE((SELECT count(*) FROM filtered), 0),";
        sql << "'avg_temperature', (SELECT avg(avg_temperature) FROM filtered),";
        sql << "'avg_humidity', (SELECT avg(avg_humidity) FROM filtered),";
        sql << "'avg_wind_speed', (SELECT avg(avg_wind_speed) FROM filtered),";
        sql << "'avg_pressure_hpa', (SELECT avg(avg_pressure_hpa) FROM filtered),";
        sql << "'avg_cloud_cover', (SELECT avg(avg_cloud_cover) FROM filtered),";
        sql << "'min_visibility_km', (SELECT min(min_visibility_km) FROM filtered),";
        sql << "'max_precipitation_mm', (SELECT max(max_precipitation_mm) FROM filtered),";
        sql << "'avg_hazard_score', (SELECT avg(hazard_score) FROM filtered),";
        sql << "'layer_value', (SELECT avg(" << layerExpr << ") FROM filtered),";
        sql << "'source', 'timescale',";
        sql << "'as_of', '" << sqlEscape(asOf) << "'";
        sql << ")::text;";

        auto response = readClient_.queryJson(sql.str());
        if (!response.has_value() || !response->is_object()) {
            return std::nullopt;
        }

        return response;
    }

    json fallbackTileSnapshot(const std::string& layer,
                              const std::optional<double>& minLat,
                              const std::optional<double>& minLon,
                              const std::optional<double>& maxLat,
                              const std::optional<double>& maxLon,
                              const std::string& asOf = "") const {
        return {
            {"layer", layer},
            {"count", 0},
            {"tiles", json::array()},
            {"source", "live_unavailable"},
            {"as_of", asOf}
        };
    }

    json fallbackRouteRiskSnapshot(const std::string& routeId,
                                    const std::vector<std::string>& segmentIds,
                                    const std::string& asOf = "") const {
        return {
            {"route_id", routeId},
            {"segment_count", 0},
            {"route_hazard_score", 0.0},
            {"route_delay_factor", 1.0},
            {"projected_eta_delta_minutes", 0.0},
            {"segments", json::array()},
            {"source", "live_unavailable"},
            {"route_polyline", json::array()},
            {"as_of", asOf}
        };
    }

    json fallbackMapSummarySnapshot(const std::string& layer,
                                    const std::optional<double>& minLat,
                                    const std::optional<double>& minLon,
                                    const std::optional<double>& maxLat,
                                    const std::optional<double>& maxLon,
                                    const std::string& asOf = "") const {
        return {
            {"layer", layer},
            {"tile_count", 0},
            {"avg_temperature", nullptr},
            {"avg_humidity", nullptr},
            {"avg_wind_speed", nullptr},
            {"avg_pressure_hpa", nullptr},
            {"avg_cloud_cover", nullptr},
            {"min_visibility_km", nullptr},
            {"max_precipitation_mm", nullptr},
            {"avg_hazard_score", nullptr},
            {"layer_value", nullptr},
            {"source", "live_unavailable"},
            {"as_of", asOf}
        };
    }
    TimescaleReadClient readClient_;
    std::map<std::string, CityCoordinate> cityCoordinates_;
};

std::string trim(const std::string& value) {
    std::size_t start = 0;
    while (start < value.size() && std::isspace(static_cast<unsigned char>(value[start]))) {
        ++start;
    }

    std::size_t end = value.size();
    while (end > start && std::isspace(static_cast<unsigned char>(value[end - 1]))) {
        --end;
    }

    return value.substr(start, end - start);
}

std::map<std::string, std::string> parseQuery(const std::string& queryString) {
    std::map<std::string, std::string> result;
    std::size_t start = 0;
    while (start < queryString.size()) {
        std::size_t end = queryString.find('&', start);
        if (end == std::string::npos) {
            end = queryString.size();
        }

        std::string pair = queryString.substr(start, end - start);
        std::size_t equals = pair.find('=');
        if (equals != std::string::npos) {
            result[trim(pair.substr(0, equals))] = trim(pair.substr(equals + 1));
        } else if (!pair.empty()) {
            result[trim(pair)] = "";
        }

        start = end + 1;
    }
    return result;
}

std::optional<double> parseDouble(const std::map<std::string, std::string>& query, const std::string& key) {
    auto it = query.find(key);
    if (it == query.end() || it->second.empty()) {
        return std::nullopt;
    }
    try {
        return std::stod(it->second);
    } catch (...) {
        return std::nullopt;
    }
}

std::vector<std::string> splitCsv(const std::string& value) {
    std::vector<std::string> parts;
    std::size_t start = 0;
    while (start < value.size()) {
        std::size_t end = value.find(',', start);
        if (end == std::string::npos) {
            end = value.size();
        }
        std::string item = trim(value.substr(start, end - start));
        if (!item.empty()) {
            parts.push_back(item);
        }
        start = end + 1;
    }
    return parts;
}

std::vector<std::string> splitPath(const std::string& value) {
    std::vector<std::string> parts;
    std::size_t start = 0;
    while (start < value.size()) {
        std::size_t end = value.find('/', start);
        if (end == std::string::npos) {
            end = value.size();
        }
        std::string item = value.substr(start, end - start);
        if (!item.empty()) {
            parts.push_back(item);
        }
        start = end + 1;
    }
    return parts;
}

std::string statusText(int code) {
    switch (code) {
        case 200: return "OK";
        case 400: return "Bad Request";
        case 404: return "Not Found";
        default: return "Internal Server Error";
    }
}

std::string makeHttpResponse(int code, const json& payload, const std::vector<std::pair<std::string, std::string>>& extraHeaders = {}) {
    const std::string body = payload.dump(2);
    std::ostringstream response;
    response << "HTTP/1.1 " << code << ' ' << statusText(code) << "\r\n";
    response << "Content-Type: application/json\r\n";
    response << "Access-Control-Allow-Origin: *\r\n";
    response << "Access-Control-Allow-Methods: GET, POST, OPTIONS\r\n";
    response << "Access-Control-Allow-Headers: Content-Type\r\n";
    for (const auto& header : extraHeaders) {
        response << header.first << ": " << header.second << "\r\n";
    }
    response << "Content-Length: " << body.size() << "\r\n";
    response << "Connection: close\r\n\r\n";
    response << body;
    return response.str();
}

std::string makeBinaryHttpResponse(int code, const std::vector<unsigned char>& body, const std::vector<std::pair<std::string, std::string>>& extraHeaders = {}) {
    std::ostringstream response;
    response << "HTTP/1.1 " << code << ' ' << statusText(code) << "\r\n";
    response << "Content-Type: image/png\r\n";
    response << "Access-Control-Allow-Origin: *\r\n";
    for (const auto& header : extraHeaders) {
        response << header.first << ": " << header.second << "\r\n";
    }
    response << "Content-Length: " << body.size() << "\r\n";
    response << "Connection: close\r\n\r\n";
    std::string out = response.str();
    out.append(reinterpret_cast<const char*>(body.data()), body.size());
    return out;
}

static inline std::string base64_chars =
    "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    "abcdefghijklmnopqrstuvwxyz"
    "0123456789+/";

static inline bool is_base64(unsigned char c) {
    return (isalnum(c) || (c == '+') || (c == '/'));
}

std::vector<unsigned char> base64_decode(const std::string& encoded_string) {
    int in_len = static_cast<int>(encoded_string.size());
    int i = 0;
    int in_ = 0;
    unsigned char char_array_4[4], char_array_3[3];
    std::vector<unsigned char> ret;

    while (in_len-- && (encoded_string[in_] != '=') && is_base64(encoded_string[in_])) {
        char_array_4[i++] = encoded_string[in_]; in_++;
        if (i ==4) {
            for (i = 0; i <4; i++)
                char_array_4[i] = static_cast<unsigned char>(base64_chars.find(char_array_4[i]));

            char_array_3[0] = (char_array_4[0] << 2) + ((char_array_4[1] & 0x30) >> 4);
            char_array_3[1] = ((char_array_4[1] & 0xf) << 4) + ((char_array_4[2] & 0x3c) >> 2);
            char_array_3[2] = ((char_array_4[2] & 0x3) << 6) + char_array_4[3];

            for (i = 0; (i < 3); i++)
                ret.push_back(char_array_3[i]);
            i = 0;
        }
    }

    if (i) {
        for (int j = i; j <4; j++)
            char_array_4[j] = 0;

        for (int j = 0; j <4; j++)
            char_array_4[j] = static_cast<unsigned char>(base64_chars.find(char_array_4[j]));

        char_array_3[0] = ( char_array_4[0] << 2 ) + ( (char_array_4[1] & 0x30) >> 4 );
        char_array_3[1] = ( (char_array_4[1] & 0xf) << 4 ) + ( (char_array_4[2] & 0x3c) >> 2 );
        char_array_3[2] = ( (char_array_4[2] & 0x3) << 6 ) + char_array_4[3];

        for (int j = 0; (j < i - 1); j++) ret.push_back(char_array_3[j]);
    }

    return ret;
}

std::optional<HttpRequest> parseHttpRequest(const std::string& raw) {
    const std::size_t headerEnd = raw.find("\r\n\r\n");
    if (headerEnd == std::string::npos) {
        return std::nullopt;
    }

    std::istringstream headerStream(raw.substr(0, headerEnd));
    std::string requestLine;
    if (!std::getline(headerStream, requestLine)) {
        return std::nullopt;
    }

    if (!requestLine.empty() && requestLine.back() == '\r') {
        requestLine.pop_back();
    }

    std::istringstream requestLineStream(requestLine);
    HttpRequest request;
    std::string uri;
    requestLineStream >> request.method >> uri;
    if (request.method.empty() || uri.empty()) {
        return std::nullopt;
    }

    const std::size_t queryPos = uri.find('?');
    if (queryPos == std::string::npos) {
        request.path = uri;
    } else {
        request.path = uri.substr(0, queryPos);
        request.query = parseQuery(uri.substr(queryPos + 1));
    }

    const std::string bodyText = raw.substr(headerEnd + 4);
    if (!bodyText.empty()) {
        try {
            request.body = json::parse(bodyText);
        } catch (...) {
            request.body = json::object();
        }
    }

    return request;
}

int readBody(int fd, std::string& requestText) {
    requestText.clear();
    char buffer[4096];

    while (true) {
        ssize_t received = recv(fd, buffer, sizeof(buffer), 0);
        if (received < 0) {
            return -1;
        }
        if (received == 0) {
            break;
        }
        requestText.append(buffer, static_cast<std::size_t>(received));
        if (requestText.find("\r\n\r\n") != std::string::npos) {
            break;
        }
    }
    return 0;
}

void handleConnection(int clientFd, const MapQueryStore& store) {
    std::string requestText;
    if (readBody(clientFd, requestText) < 0) {
        close(clientFd);
        return;
    }

    auto requestOpt = parseHttpRequest(requestText);
    if (!requestOpt.has_value()) {
        const std::string response = makeHttpResponse(400, { {"error", "invalid http request"} });
        send(clientFd, response.c_str(), response.size(), 0);
        close(clientFd);
        return;
    }

    const HttpRequest& request = *requestOpt;
    json payload;
    int code = 200;

    if (request.method == "OPTIONS") {
        const std::string response = makeHttpResponse(200, json::object());
        send(clientFd, response.c_str(), response.size(), 0);
        close(clientFd);
        return;
    }

    if ((request.method == "GET" || request.method == "HEAD") && request.path == "/v1/health") {
        payload = {
            {"status", "ok"},
            {"service", "map_query_api"}
        };
    } else if (request.method == "GET" && request.path == "/v1/map/tiles/png") {
        const auto zIt = request.query.find("z");
        const auto xIt = request.query.find("x");
        const auto yIt = request.query.find("y");
        const auto layerIt = request.query.find("layer");
        const auto atIt = request.query.find("at");

        if (zIt == request.query.end() || xIt == request.query.end() || yIt == request.query.end()) {
            code = 400;
            payload = {{"error", "missing z/x/y"}};
        } else {
            try {
                const int z = std::stoi(zIt->second);
                const int x = std::stoi(xIt->second);
                const int y = std::stoi(yIt->second);
                const std::string layer = layerIt != request.query.end() ? layerIt->second : "hazard";
                const std::string asOf = atIt != request.query.end() ? atIt->second : "";

                if (auto bytes = store.renderTilePng(layer, z, x, y, asOf); bytes.has_value()) {
                    const std::string response = makeBinaryHttpResponse(200, *bytes);
                    send(clientFd, response.c_str(), response.size(), 0);
                    close(clientFd);
                    return;
                }

                // Fallback: return a transparent 256x256 PNG instead of 404 so map clients
                // can render an empty tile rather than showing missing tiles.
                std::vector<unsigned char> emptyRgba(static_cast<std::size_t>(kTileSize) * kTileSize * 4, 0);
                const auto emptyPng = encodePngRgba(kTileSize, kTileSize, emptyRgba);
                const std::string response = makeBinaryHttpResponse(200, emptyPng);
                send(clientFd, response.c_str(), response.size(), 0);
                close(clientFd);
                return;
            } catch (...) {
                code = 400;
                payload = {{"error", "invalid z/x/y"}};
            }
        }
    } else if (request.method == "GET" && request.path.rfind("/v1/map/tiles/png/", 0) == 0) {
        const auto pathParts = splitPath(request.path.substr(std::string("/v1/map/tiles/png/").size()));
        const auto layerIt = request.query.find("layer");
        const auto atIt = request.query.find("at");

        if (pathParts.size() < 3) {
            code = 400;
            payload = {{"error", "missing z/x/y"}};
        } else {
            try {
                const int z = std::stoi(pathParts[0]);
                const int x = std::stoi(pathParts[1]);
                const int y = std::stoi(pathParts[2]);
                const std::string layer = layerIt != request.query.end() ? layerIt->second : "hazard";
                const std::string asOf = atIt != request.query.end() ? atIt->second : "";

                if (auto bytes = store.renderTilePng(layer, z, x, y, asOf); bytes.has_value()) {
                    const std::string response = makeBinaryHttpResponse(200, *bytes);
                    send(clientFd, response.c_str(), response.size(), 0);
                    close(clientFd);
                    return;
                }

                std::vector<unsigned char> emptyRgba(static_cast<std::size_t>(kTileSize) * kTileSize * 4, 0);
                const auto emptyPng = encodePngRgba(kTileSize, kTileSize, emptyRgba);
                const std::string response = makeBinaryHttpResponse(200, emptyPng);
                send(clientFd, response.c_str(), response.size(), 0);
                close(clientFd);
                return;
            } catch (...) {
                code = 400;
                payload = {{"error", "invalid z/x/y"}};
            }
        }
    } else if (request.method == "POST" && request.path == "/v1/map/tiles/refresh") {
        const auto zIt = request.query.find("z");
        const auto xIt = request.query.find("x");
        const auto yIt = request.query.find("y");
        const auto layerIt = request.query.find("layer");
        const auto atIt = request.query.find("at");

        if (zIt == request.query.end() || xIt == request.query.end() || yIt == request.query.end()) {
            code = 400;
            payload = {{"error", "missing z/x/y"}};
        } else {
            try {
                const int z = std::stoi(zIt->second);
                const int x = std::stoi(xIt->second);
                const int y = std::stoi(yIt->second);
                const std::string layer = layerIt != request.query.end() ? layerIt->second : "hazard";
                const std::string asOf = atIt != request.query.end() ? atIt->second : "";

                if (!store.readClient_.isEnabled()) {
                    code = 404;
                    payload = {{"error", "timescale not configured"}};
                } else {
                    std::ostringstream sql;
                    sql << "SELECT encode(refresh_map_tile(" << z << "," << x << "," << y << ", '" << MapQueryStore::sqlEscape(layer) << "', ";
                    if (!asOf.empty()) {
                        sql << "'" << MapQueryStore::sqlEscape(asOf) << "'::timestamptz";
                    } else {
                        sql << "NULL::timestamptz";
                    }
                    sql << "), 'base64')";
                    if (auto res = store.readClient_.queryScalar(sql.str()); res.has_value()) {
                        payload = {{"ok", true}, {"tile_base64_len", static_cast<int>(res->size())}};
                    } else {
                        code = 500;
                        payload = {{"error", "refresh failed"}};
                    }
                }
            } catch (...) {
                code = 400;
                payload = {{"error", "invalid z/x/y"}};
            }
        }
    } else if (request.method == "GET" && request.path == "/v1/map/tiles") {
        const auto layerIt = request.query.find("layer");
        const std::string layer = layerIt != request.query.end() ? layerIt->second : "hazard";
        const auto atIt = request.query.find("at");
        const std::string asOf = atIt != request.query.end() ? atIt->second : "";
        const auto bbox = request.query.find("bbox");
        std::optional<double> minLat;
        std::optional<double> minLon;
        std::optional<double> maxLat;
        std::optional<double> maxLon;

        if (bbox != request.query.end()) {
            const auto parts = splitCsv(bbox->second);
            if (parts.size() == 4) {
                try {
                    minLon = std::stod(parts[0]);
                    minLat = std::stod(parts[1]);
                    maxLon = std::stod(parts[2]);
                    maxLat = std::stod(parts[3]);
                } catch (...) {
                    code = 400;
                    payload = {{"error", "invalid bbox format"}};
                }
            }
        }

        if (code == 200) {
            payload = store.tileSnapshot(layer, minLat, minLon, maxLat, maxLon, asOf);
        }
    } else if (request.method == "GET" && request.path == "/v1/map/summary") {
        const auto layerIt = request.query.find("layer");
        const std::string layer = layerIt != request.query.end() ? layerIt->second : "hazard";
        const auto atIt = request.query.find("at");
        const std::string asOf = atIt != request.query.end() ? atIt->second : "";
        const auto bbox = request.query.find("bbox");
        std::optional<double> minLat;
        std::optional<double> minLon;
        std::optional<double> maxLat;
        std::optional<double> maxLon;

        if (bbox != request.query.end()) {
            const auto parts = splitCsv(bbox->second);
            if (parts.size() == 4) {
                try {
                    minLon = std::stod(parts[0]);
                    minLat = std::stod(parts[1]);
                    maxLon = std::stod(parts[2]);
                    maxLat = std::stod(parts[3]);
                } catch (...) {
                    code = 400;
                    payload = {{"error", "invalid bbox format"}};
                }
            }
        }

        if (code == 200) {
            if (auto summary = store.mapSummaryFromDb(layer, minLat, minLon, maxLat, maxLon, asOf); summary.has_value()) {
                payload = *summary;
            } else {
                payload = store.fallbackMapSummarySnapshot(layer, minLat, minLon, maxLat, maxLon, asOf);
            }
        }
    } else if (request.method == "POST" && request.path == "/v1/routes/risk") {
        if (!request.body.is_object()) {
            code = 400;
            payload = {{"error", "expected json body"}};
        } else {
            const std::string routeId = request.body.value("route_id", "route.unknown");
            const std::string asOf = request.body.value("at", "");
            std::vector<std::string> segmentIds;
            if (request.body.contains("segment_ids") && request.body["segment_ids"].is_array()) {
                for (const auto& segment : request.body["segment_ids"]) {
                    if (segment.is_string()) {
                        segmentIds.push_back(segment.get<std::string>());
                    }
                }
            }
            if (segmentIds.empty()) {
                segmentIds = {routeId + ".segment_1", routeId + ".segment_2"};
            }
            payload = store.routeRiskSnapshot(routeId, segmentIds, asOf);
        }
    } else {
        code = 404;
        payload = {{"error", "not found"}};
    }

    const std::string response = makeHttpResponse(code, payload);
    send(clientFd, response.c_str(), response.size(), 0);
    close(clientFd);
}

} // namespace

int main(int argc, char* argv[]) {
    std::signal(SIGINT, handleShutdownSignal);
    std::signal(SIGTERM, handleShutdownSignal);

    int port = 8080;
    if (argc > 1) {
        port = std::stoi(argv[1]);
    }

    int serverFd = socket(AF_INET, SOCK_STREAM, 0);
    if (serverFd < 0) {
        std::cerr << "Failed to create server socket" << std::endl;
        return 1;
    }

    int opt = 1;
    setsockopt(serverFd, SOL_SOCKET, SO_REUSEADDR, &opt, sizeof(opt));

    sockaddr_in addr{};
    addr.sin_family = AF_INET;
    addr.sin_addr.s_addr = INADDR_ANY;
    addr.sin_port = htons(port);

    if (bind(serverFd, reinterpret_cast<sockaddr*>(&addr), sizeof(addr)) < 0) {
        std::cerr << "Failed to bind to port " << port << std::endl;
        close(serverFd);
        return 1;
    }

    if (listen(serverFd, 16) < 0) {
        std::cerr << "Failed to listen on port " << port << std::endl;
        close(serverFd);
        return 1;
    }

    std::cout << "[map_query_api] listening on port " << port << std::endl;
    std::cout << "[map_query_api] endpoints: GET /v1/health, GET /v1/map/tiles, GET /v1/map/summary, POST /v1/routes/risk" << std::endl;

    MapQueryStore store;

    while (running.load()) {
        pollfd pfd{};
        pfd.fd = serverFd;
        pfd.events = POLLIN;

        int pollResult = poll(&pfd, 1, 1000);
        if (pollResult == 0) {
            continue;
        }
        if (pollResult < 0) {
            if (running.load()) {
                std::cerr << "[map_query_api] poll error" << std::endl;
            }
            continue;
        }

        sockaddr_in clientAddr{};
        socklen_t clientLen = sizeof(clientAddr);
        int clientFd = accept(serverFd, reinterpret_cast<sockaddr*>(&clientAddr), &clientLen);
        if (clientFd < 0) {
            continue;
        }

        std::thread([clientFd, &store]() {
            handleConnection(clientFd, store);
        }).detach();
    }

    close(serverFd);
    return 0;
}
