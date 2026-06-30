#include <iostream>
#include <unistd.h>
#include <arpa/inet.h>
#include <cstring>
#include <thread>
#include <chrono>
#include <vector>

#include <curl/curl.h>
#include <nlohmann/json.hpp>

#include "../common/protocol/MessageEnvelope.hpp"
#include "../common/models/WeatherPacket.hpp"
#include "../common/protocol/MessageTypes.hpp"

using json = nlohmann::json;

#define PORT 13101
#define NUM_STATIONS_PER_CITY 5

// ---- City definitions ----
struct CityConfig {
    std::string name;
    double latitude;
    double longitude;
    std::string region;
    std::string country;
    std::string continent;
};

static const std::vector<CityConfig> CITIES = {
    // India
    {"Chennai",    13.0827,  80.2707, "south_india",  "India", "Asia"},
    {"Bangalore",  12.9716,  77.5946, "south_india",  "India", "Asia"},
    {"Mumbai",     19.0760,  72.8777, "west_india",   "India", "Asia"},
    {"Delhi",      28.6139,  77.2090, "north_india",  "India", "Asia"},
    {"Hyderabad",  17.3850,  78.4867, "south_india",  "India", "Asia"},
    {"Kolkata",    22.5726,  88.3639, "east_india",   "India", "Asia"},
    {"Kochi",       9.9312,  76.2673, "south_india",  "India", "Asia"},
    {"Ahmedabad",  23.0225,  72.5714, "west_india",   "India", "Asia"},
    {"Pune",       18.5204,  73.8567, "west_india",   "India", "Asia"},
    {"Jaipur",     26.9124,  75.7873, "north_india",  "India", "Asia"},
    // International
    {"Singapore",   1.3521, 103.8198, "southeast_asia", "Singapore", "Asia"},
    {"Tokyo",      35.6762, 139.6503, "east_asia",      "Japan",     "Asia"},
    {"Dubai",      25.2048,  55.2708, "middle_east",    "UAE",       "Asia"},
    {"London",     51.5074,  -0.1278, "europe",         "UK",        "Europe"},
    {"New York",   40.7128, -74.0060, "north_america",  "USA",       "North America"},
    {"Sydney",    -33.8688, 151.2093, "oceania",        "Australia", "Oceania"},
};

size_t WriteCallback(void* contents,
                     size_t size,
                     size_t nmemb,
                     std::string* output) {
    output->append((char*)contents, size * nmemb);
    return size * nmemb;
}

std::string fetchWeatherForCity(const CityConfig& city) {
    CURL* curl;
    CURLcode res;
    std::string response;

    curl = curl_easy_init();

    if (curl) {
        char url[512];
        snprintf(url, sizeof(url),
            "https://api.open-meteo.com/v1/forecast?"
            "latitude=%.4f&longitude=%.4f&"
            "current=temperature_2m,relative_humidity_2m,"
            "wind_speed_10m,cloud_cover,visibility,"
            "precipitation,pressure_msl",
            city.latitude, city.longitude);

        curl_easy_setopt(curl, CURLOPT_URL, url);
        curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, WriteCallback);
        curl_easy_setopt(curl, CURLOPT_WRITEDATA, &response);
        curl_easy_setopt(curl, CURLOPT_TIMEOUT, 10L);

        res = curl_easy_perform(curl);

        if (res != CURLE_OK) {
            std::cerr << "[" << city.name << "] curl failed: "
                      << curl_easy_strerror(res)
                      << std::endl;
        }

        curl_easy_cleanup(curl);
    }

    return response;
}

int main(int argc, char* argv[]) {
    int port = PORT;
    if (argc > 1) {
        port = std::stoi(argv[1]);
    }

    int sock = socket(AF_INET, SOCK_STREAM, 0);

    if (sock < 0) {
        std::cerr << "Socket creation failed\n";
        return 1;
    }

    sockaddr_in serv_addr{};
    serv_addr.sin_family = AF_INET;
    serv_addr.sin_port = htons(port);

    inet_pton(AF_INET, "127.0.0.1", &serv_addr.sin_addr);

    if (connect(sock,
                (struct sockaddr*)&serv_addr,
                sizeof(serv_addr)) < 0) {
        std::cerr << "Connection failed on port " << port << "\n";
        return 1;
    }

    std::cout << "Connected to aggregator/comparator on port " << port << "\n";
    std::cout << "Polling " << CITIES.size() << " cities every 10 seconds\n";

    // Cycle through cities to avoid hammering the API
    size_t cityIndex = 0;

    while (true) {
        // Fetch 4 cities per cycle (to stay within Open-Meteo rate limits)
        int citiesThisCycle = std::min((size_t)4, CITIES.size());
        int totalPackets = 0;

        for (int c = 0; c < citiesThisCycle; c++) {
            const CityConfig& city = CITIES[cityIndex % CITIES.size()];
            cityIndex++;

            std::string apiResponse = fetchWeatherForCity(city);

            if (apiResponse.empty()) {
                continue;
            }

            try {
                auto data = json::parse(apiResponse);
                const auto& current = data["current"];

                for (int station = 1; station <= NUM_STATIONS_PER_CITY; station++) {

                    WeatherPacket packet;

                    packet.city = city.name;

                    packet.latitude =
                        city.latitude + (station * 0.001);

                    packet.longitude =
                        city.longitude + (station * 0.001);

                    packet.temperature =
                        current.value("temperature_2m", 0.0);

                    packet.humidity =
                        current.value("relative_humidity_2m", 0.0);

                    packet.wind_speed =
                        current.value("wind_speed_10m", 0.0);

                    if (current.contains("cloud_cover"))
                        packet.cloud_cover_percent =
                            current["cloud_cover"];

                    if (current.contains("visibility"))
                        packet.visibility_km =
                            current["visibility"]
                                .get<double>() / 1000.0;

                    if (current.contains("precipitation"))
                        packet.precipitation_mm =
                            current["precipitation"];

                    if (current.contains("pressure_msl"))
                        packet.pressure_hpa =
                            current["pressure_msl"];

                    packet.continent = city.continent;
                    packet.country = city.country;
                    packet.region = city.region;

                    // Lowercase + hyphenated station ID
                    std::string cityLower = city.name;
                    for (auto& ch : cityLower) {
                        if (ch == ' ') ch = '-';
                        else ch = std::tolower(ch);
                    }
                    packet.station_id =
                        cityLower + "-station-" +
                        std::to_string(station);

                    packet.timestamp =
                        std::chrono::duration_cast<
                            std::chrono::milliseconds>(
                            std::chrono::system_clock::now()
                                .time_since_epoch())
                            .count();

                    MessageEnvelope envelope =
                        make_weather_packet_envelope(
                            packet,
                            "simulator",
                            city.region);

                    std::string message =
                        envelope_to_json(envelope).dump();

                    message += "\n";

                    ssize_t bytes =
                        send(sock,
                             message.c_str(),
                             message.size(),
                             0);

                    if (bytes < 0) {
                        std::cerr
                            << "Failed to send packet from "
                            << packet.station_id
                            << std::endl;
                    }

                    totalPackets++;
                }

            } catch (const std::exception& e) {
                std::cerr << "[" << city.name << "] JSON parse error: "
                          << e.what()
                          << std::endl;
            }

            // Small delay between cities to avoid API rate limits
            std::this_thread::sleep_for(
                std::chrono::milliseconds(300));
        }

        std::cout
            << "Sent "
            << totalPackets
            << " weather packets from "
            << citiesThisCycle
            << " cities"
            << std::endl;

        // Wait before next cycle
        std::this_thread::sleep_for(
            std::chrono::seconds(10));
    }

    close(sock);
    return 0;
}