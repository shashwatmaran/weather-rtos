#pragma once

#include <string>
#include <vector>

struct CitySamplePoint {
    std::string label;
    std::string layer;
    double latitude;
    double longitude;
};

inline std::vector<CitySamplePoint> makeCitySamplePoints(const std::string& city,
                                                         double latitude,
                                                         double longitude,
                                                         double offsetDegrees = 0.025) {
    return {
        {city + "_center", "city_center", latitude, longitude},
        {city + "_north", "city_waypoint", latitude + offsetDegrees, longitude},
        {city + "_east", "city_waypoint", latitude, longitude + offsetDegrees},
        {city + "_south", "city_waypoint", latitude - offsetDegrees, longitude},
        {city + "_west", "city_waypoint", latitude, longitude - offsetDegrees}
    };
}