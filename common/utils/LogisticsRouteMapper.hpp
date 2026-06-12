#pragma once

#include <string>
#include <vector>
#include <map>
#include <cmath>
#include "../models/WeatherPacket.hpp"

/**
 * Logistics Route Mapping System
 * 
 * Defines logistics corridors and maps weather data to route segments.
 * Calculates dynamic risk based on real-time weather observations.
 */
struct RouteWaypoint {
    std::string name;
    double latitude;
    double longitude;
};

struct LogisticsRoute {
    std::string route_id;
    std::string name;
    std::vector<RouteWaypoint> waypoints;
};

class LogisticsRouteMapper {
public:
    LogisticsRouteMapper() {
        initializeStandardRoutes();
    }

    /**
     * Finds the nearest route segment for a given weather observation.
     */
    std::string findNearestSegment(double lat, double lon, std::string& route_id) {
        double min_dist = 1e18;
        std::string nearest_segment = "unknown";
        
        for (const auto& [id, route] : routes_) {
            for (const auto& wp : route.waypoints) {
                double d = haversine(lat, lon, wp.latitude, wp.longitude);
                if (d < min_dist && d < 50.0) { // Within 50km
                    min_dist = d;
                    nearest_segment = wp.name;
                    route_id = id;
                }
            }
        }
        return nearest_segment;
    }

    const std::map<std::string, LogisticsRoute>& getRoutes() const {
        return routes_;
    }

private:
    void initializeStandardRoutes() {
        // Golden Quadrilateral: Delhi - Mumbai - Bangalore - Chennai
        LogisticsRoute dm;
        dm.route_id = "GQ-WEST";
        dm.name = "Delhi-Mumbai Corridor";
        dm.waypoints = {
            {"Delhi_Exit", 28.6139, 77.2090},
            {"Gurugram_Hub", 28.4595, 77.0266},
            {"Jaipur_Bypass", 26.9124, 75.7873},
            {"Ajmer_Waypoint", 26.4499, 74.6399},
            {"Udaipur_Crossing", 24.5854, 73.7125},
            {"Ahmedabad_Hub", 23.0225, 72.5714},
            {"Surat_Waypoint", 21.1702, 72.8311},
            {"Mumbai_Entry", 19.0760, 72.8777}
        };
        routes_[dm.route_id] = dm;

        LogisticsRoute mb;
        mb.route_id = "GQ-SOUTH-WEST";
        mb.name = "Mumbai-Bangalore Corridor";
        mb.waypoints = {
            {"Mumbai_Exit", 19.0760, 72.8777},
            {"Pune_Hub", 18.5204, 73.8567},
            {"Satara_Waypoint", 17.6805, 73.9918},
            {"Kolhapur_Waypoint", 16.7050, 74.2433},
            {"Belagavi_Crossing", 15.8497, 74.4977},
            {"Hubballi_Hub", 15.3647, 75.1240},
            {"Tumakuru_Waypoint", 13.3392, 77.1140},
            {"Bangalore_Entry", 12.9716, 77.5946}
        };
        routes_[mb.route_id] = mb;
    }

    double haversine(double lat1, double lon1, double lat2, double lon2) {
        double dLat = (lat2 - lat1) * M_PI / 180.0;
        double dLon = (lon2 - lon1) * M_PI / 180.0;
        lat1 = lat1 * M_PI / 180.0;
        lat2 = lat2 * M_PI / 180.0;

        double a = pow(sin(dLat / 2), 2) + pow(sin(dLon / 2), 2) * cos(lat1) * cos(lat2);
        double rad = 6371; // Earth radius in km
        double c = 2 * asin(sqrt(a));
        return rad * c;
    }

    std::map<std::string, LogisticsRoute> routes_;
};
