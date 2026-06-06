#pragma once

#include <cmath>
#include <limits>
#include <string>
#include <nlohmann/json.hpp>

using json = nlohmann::json;

struct WeatherPacket {
    std::string continent;
    std::string country;
    std::string region;
    std::string city;

    double temperature;
    double humidity;
    double wind_speed;

    long timestamp;

    // Optional geospatial and weather-intensity fields for map analytics.
    double latitude = std::numeric_limits<double>::quiet_NaN();
    double longitude = std::numeric_limits<double>::quiet_NaN();
    double visibility_km = std::numeric_limits<double>::quiet_NaN();
    double precipitation_mm = std::numeric_limits<double>::quiet_NaN();
    double pressure_hpa = std::numeric_limits<double>::quiet_NaN();
    double cloud_cover_percent = std::numeric_limits<double>::quiet_NaN();
    std::string station_id;
    std::string ingest_layer;
    std::string sample_point;
};

inline WeatherPacket weather_packet_from_json(const json& packetJson) {
    WeatherPacket packet{
        packetJson.at("continent").get<std::string>(),
        packetJson.at("country").get<std::string>(),
        packetJson.at("region").get<std::string>(),
        packetJson.at("city").get<std::string>(),
        packetJson.at("temperature").get<double>(),
        packetJson.at("humidity").get<double>(),
        packetJson.at("wind_speed").get<double>(),
        packetJson.at("timestamp").get<long>()
    };

    if (packetJson.contains("latitude") && packetJson["latitude"].is_number()) {
        packet.latitude = packetJson["latitude"].get<double>();
    }
    if (packetJson.contains("longitude") && packetJson["longitude"].is_number()) {
        packet.longitude = packetJson["longitude"].get<double>();
    }
    if (packetJson.contains("visibility_km") && packetJson["visibility_km"].is_number()) {
        packet.visibility_km = packetJson["visibility_km"].get<double>();
    }
    if (packetJson.contains("precipitation_mm") && packetJson["precipitation_mm"].is_number()) {
        packet.precipitation_mm = packetJson["precipitation_mm"].get<double>();
    }
    if (packetJson.contains("pressure_hpa") && packetJson["pressure_hpa"].is_number()) {
        packet.pressure_hpa = packetJson["pressure_hpa"].get<double>();
    }
    if (packetJson.contains("cloud_cover_percent") && packetJson["cloud_cover_percent"].is_number()) {
        packet.cloud_cover_percent = packetJson["cloud_cover_percent"].get<double>();
    }
    if (packetJson.contains("station_id") && packetJson["station_id"].is_string()) {
        packet.station_id = packetJson["station_id"].get<std::string>();
    }
    if (packetJson.contains("ingest_layer") && packetJson["ingest_layer"].is_string()) {
        packet.ingest_layer = packetJson["ingest_layer"].get<std::string>();
    }
    if (packetJson.contains("sample_point") && packetJson["sample_point"].is_string()) {
        packet.sample_point = packetJson["sample_point"].get<std::string>();
    }

    return packet;
}

inline json to_json(const WeatherPacket& packet) {
    json result = {
        {"continent", packet.continent},
        {"country", packet.country},
        {"region", packet.region},
        {"city", packet.city},
        {"temperature", packet.temperature},
        {"humidity", packet.humidity},
        {"wind_speed", packet.wind_speed},
        {"timestamp", packet.timestamp}
    };

    if (!std::isnan(packet.latitude)) {
        result["latitude"] = packet.latitude;
    }
    if (!std::isnan(packet.longitude)) {
        result["longitude"] = packet.longitude;
    }
    if (!std::isnan(packet.visibility_km)) {
        result["visibility_km"] = packet.visibility_km;
    }
    if (!std::isnan(packet.precipitation_mm)) {
        result["precipitation_mm"] = packet.precipitation_mm;
    }
    if (!std::isnan(packet.pressure_hpa)) {
        result["pressure_hpa"] = packet.pressure_hpa;
    }
    if (!std::isnan(packet.cloud_cover_percent)) {
        result["cloud_cover_percent"] = packet.cloud_cover_percent;
    }
    if (!packet.station_id.empty()) {
        result["station_id"] = packet.station_id;
    }
    if (!packet.ingest_layer.empty()) {
        result["ingest_layer"] = packet.ingest_layer;
    }
    if (!packet.sample_point.empty()) {
        result["sample_point"] = packet.sample_point;
    }

    return result;
}