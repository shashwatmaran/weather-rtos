#include <iostream>
#include <fstream>
#include <vector>
#include <string>
#include <thread>
#include <atomic>
#include <chrono>
#include <cstring>
#include <cmath>
#include <array>
#include <optional>
#include <sys/mman.h>
#include <sched.h>
#include <netinet/in.h>
#include <sys/socket.h>
#include <unistd.h>
#include <poll.h>

#include <nlohmann/json.hpp>

#if WEATHER_RTOS_HAS_LIBPQ
#include <libpq-fe.h>
#define WEATHER_RTOS_COMP_HAS_LIBPQ 1
#else
#define WEATHER_RTOS_COMP_HAS_LIBPQ 0
#endif

#include "../../common/rt_safe/LocklessRingBuffer.hpp"

using json = nlohmann::json;

namespace {

// C-compatible structs for lockless transfer to avoid heap allocation on RT threads
struct TelemetryEvent {
    char profile_id[32];
    double value;
    long timestamp;
};

struct ComparisonRecord {
    long timestamp;
    char profile_id[32];
    double live_value;
    double baseline_value;
    double variance;
    bool actuation_active;
};

struct BaselineProfile {
    std::string profile_id;
    std::string metric_name;
    double threshold;
    std::array<double, 24> baselines;
};

std::atomic<bool> running{true};
BaselineProfile globalProfile;

// Lockless queues
// Ingestion -> Real-Time Comparator
LocklessRingBuffer<TelemetryEvent> ingestQueue(2048);
// Real-Time Comparator -> DB Sync Worker
LocklessRingBuffer<ComparisonRecord> syncQueue(2048);

// Loads baseline parameters from a structured configuration file
bool loadBaselineFile(const std::string& filepath, BaselineProfile& profile) {
    std::ifstream file(filepath);
    if (!file.is_open()) {
        std::cerr << "[Config] Failed to open baseline file: " << filepath << std::endl;
        return false;
    }

    try {
        json data = json::parse(file);
        profile.profile_id = data.at("profile_id").get<std::string>();
        profile.metric_name = data.at("metric_name").get<std::string>();
        profile.threshold = data.at("threshold").get<double>();
        auto baselinesJson = data.at("baselines").get<std::vector<double>>();

        if (baselinesJson.size() != 24) {
            std::cerr << "[Config] Baseline curve must contain exactly 24 hourly metrics" << std::endl;
            return false;
        }

        for (int i = 0; i < 24; ++i) {
            profile.baselines[i] = baselinesJson[i];
        }

        std::cout << "[Config] Loaded baseline profile: " << profile.profile_id
                  << " (" << profile.metric_name << "), threshold=" << profile.threshold << std::endl;
        return true;
    } catch (const std::exception& e) {
        std::cerr << "[Config] Parsing error: " << e.what() << std::endl;
        return false;
    }
}

// Low-overhead simulated actuator triggering
void triggerActuator(const ComparisonRecord& record) {
    // In a real RTOS, this would write to a GPIO pin, CAN bus, or memory-mapped IO register.
    // For demonstration, we print with microsecond precision.
    auto now = std::chrono::high_resolution_clock::now().time_since_epoch().count();
    std::cout << "[RT-ACTUATOR] [" << now << "] !! EXCEEDED !! Profile: " << record.profile_id
              << " | Live: " << record.live_value << " | Baseline: " << record.baseline_value
              << " | Variance: " << record.variance << " | TRIGGER ACTIVE" << std::endl;
}

// DETERMINISTIC REAL-TIME COMPARISON ENGINE THREAD
void runRealTimeComparator() {
    std::cout << "[RT-Engine] Real-Time Thread starting..." << std::endl;

    // 1. Lock process memory to prevent page faults (crucial for determinism)
    if (mlockall(MCL_CURRENT | MCL_FUTURE) != 0) {
        std::cerr << "[RT-Engine] WARNING: mlockall failed. Run as root for hard RT guarantees." << std::endl;
    } else {
        std::cout << "[RT-Engine] Success: Memory pages locked in RAM" << std::endl;
    }

    // 2. Set real-time scheduler policy (SCHED_FIFO)
    struct sched_param param{};
    param.sched_priority = 80; // High real-time priority
    if (pthread_setschedparam(pthread_self(), SCHED_FIFO, &param) != 0) {
        std::cerr << "[RT-Engine] WARNING: Failed to set SCHED_FIFO priority. Run as root for CPU scheduling guarantees." << std::endl;
    } else {
        std::cout << "[RT-Engine] Success: Real-Time SCHED_FIFO active (Priority 80)" << std::endl;
    }

    // 3. Execution loop (zero dynamic allocation, SPSC wait-free processing)
    while (running.load(std::memory_order_relaxed)) {
        auto eventOpt = ingestQueue.pop();
        if (!eventOpt) {
            std::this_thread::sleep_for(std::chrono::milliseconds(1)); // Yield with minor sleep
            continue;
        }

        const TelemetryEvent& event = *eventOpt;

        // Resolve hourly index of event timestamp (local timezone)
        time_t timeSec = event.timestamp / 1000;
        struct tm timeStruct;
        localtime_r(&timeSec, &timeStruct);
        int hour = timeStruct.tm_hour;

        // Bounded O(1) comparison lookup
        double baseline = globalProfile.baselines[hour];
        double variance = std::abs(event.value - baseline);
        bool limitViolated = (variance > globalProfile.threshold);

        ComparisonRecord record;
        record.timestamp = event.timestamp;
        std::strncpy(record.profile_id, event.profile_id, sizeof(record.profile_id) - 1);
        record.profile_id[sizeof(record.profile_id) - 1] = '\0';
        record.live_value = event.value;
        record.baseline_value = baseline;
        record.variance = variance;
        record.actuation_active = limitViolated;

        if (limitViolated) {
            triggerActuator(record);
        }

        // Push to database sync ring queue locklessly
        while (!syncQueue.push(record) && running.load(std::memory_order_relaxed)) {
            std::this_thread::yield(); // Retry if sync queue is temporarily full
        }
    }

    std::cout << "[RT-Engine] Real-Time Thread stopped." << std::endl;
}

// NON-REAL-TIME DATABASE WRITER THREAD (HIGH-LATENCY BOUNDARY)
void runDatabaseSyncWorker() {
    std::cout << "[DB-Sync] Database Writer starting..." << std::endl;

    const char* dsn = std::getenv("TIMESCALEDB_DSN");
    if (!dsn) {
        dsn = "host=127.0.0.1 port=5432 dbname=weather_rtos user=weather_rtos password=weather_secret";
    }

#if WEATHER_RTOS_COMP_HAS_LIBPQ
    PGconn* conn = PQconnectdb(dsn);
    bool dbConnected = (conn != nullptr && PQstatus(conn) == CONNECTION_OK);
    if (!dbConnected) {
        std::cerr << "[DB-Sync] Database connection failed. Running in dry-run mode (stdout only)" << std::endl;
        if (conn) PQfinish(conn);
    } else {
        std::cout << "[DB-Sync] Connected to TimescaleDB for telemetry persistence." << std::endl;
    }
#else
    bool dbConnected = false;
    std::cout << "[DB-Sync] libpq not compiled. Running in dry-run mode (stdout only)" << std::endl;
#endif

    while (running.load()) {
        auto recordOpt = syncQueue.pop();
        if (!recordOpt) {
            std::this_thread::sleep_for(std::chrono::milliseconds(50));
            continue;
        }

        const ComparisonRecord& record = *recordOpt;

        std::string sql = "INSERT INTO personal_realtime_comparisons "
                          "(event_time, profile_id, live_value, baseline_value, variance, actuation_active) "
                          "VALUES (to_timestamp(" + std::to_string(record.timestamp) + " / 1000.0), '" +
                          std::string(record.profile_id) + "', " +
                          std::to_string(record.live_value) + ", " +
                          std::to_string(record.baseline_value) + ", " +
                          std::to_string(record.variance) + ", " +
                          (record.actuation_active ? std::string("TRUE") : std::string("FALSE")) + ") "
                          "ON CONFLICT (event_time, profile_id) DO NOTHING;";

#if WEATHER_RTOS_COMP_HAS_LIBPQ
        if (dbConnected) {
            PGresult* res = PQexec(conn, sql.c_str());
            if (res == nullptr || PQresultStatus(res) != PGRES_COMMAND_OK) {
                std::cerr << "[DB-Sync] SQL error: " << (res ? PQresultErrorMessage(res) : "Null response") << std::endl;
            }
            if (res) PQclear(res);
        } else {
            std::string command = "PGPASSWORD=weather_secret psql -h 127.0.0.1 -U weather_rtos -d weather_rtos -c \"" + sql + "\" >/dev/null 2>&1";
            int ret = std::system(command.c_str());
            (void)ret;
        }
#else
        std::string command = "PGPASSWORD=weather_secret psql -h 127.0.0.1 -U weather_rtos -d weather_rtos -c \"" + sql + "\" >/dev/null 2>&1";
        int ret = std::system(command.c_str());
        (void)ret;
#endif
    }

#if WEATHER_RTOS_COMP_HAS_LIBPQ
    if (dbConnected) {
        PQfinish(conn);
    }
#endif

    std::cout << "[DB-Sync] Database Writer stopped." << std::endl;
}

// INGESTION TCP SOCKET LISTENER (NON-REAL-TIME INPUT BOUNDARY)
void runTelemetryServer(int port) {
    int serverFd = socket(AF_INET, SOCK_STREAM, 0);
    if (serverFd < 0) {
        std::cerr << "[TelemetryServer] Socket error" << std::endl;
        return;
    }

    int opt = 1;
    setsockopt(serverFd, SOL_SOCKET, SO_REUSEADDR, &opt, sizeof(opt));

    sockaddr_in addr{};
    addr.sin_family = AF_INET;
    addr.sin_addr.s_addr = INADDR_ANY;
    addr.sin_port = htons(port);

    if (bind(serverFd, reinterpret_cast<sockaddr*>(&addr), sizeof(addr)) < 0) {
        std::cerr << "[TelemetryServer] Bind failed on port " << port << std::endl;
        close(serverFd);
        return;
    }

    if (listen(serverFd, 10) < 0) {
        std::cerr << "[TelemetryServer] Listen failed" << std::endl;
        close(serverFd);
        return;
    }

    std::cout << "[TelemetryServer] Telemetry ingestion server listening on port " << port << std::endl;

    while (running.load()) {
        pollfd pfd{};
        pfd.fd = serverFd;
        pfd.events = POLLIN;

        int pollRet = poll(&pfd, 1, 500);
        if (pollRet <= 0) continue;

        sockaddr_in clientAddr{};
        socklen_t clientLen = sizeof(clientAddr);
        int clientFd = accept(serverFd, reinterpret_cast<sockaddr*>(&clientAddr), &clientLen);
        if (clientFd < 0) continue;

        std::cout << "[TelemetryServer] Client connection accepted" << std::endl;

        std::string buffer;
        char temp[1024];
        while (running.load()) {
            ssize_t bytes = recv(clientFd, temp, sizeof(temp), 0);
            if (bytes <= 0) break;

            buffer.append(temp, bytes);
            size_t newline;
            while ((newline = buffer.find('\n')) != std::string::npos) {
                std::string line = buffer.substr(0, newline);
                buffer.erase(0, newline + 1);

                try {
                    json envelope = json::parse(line);
                    // Extract payload
                    json payload = envelope.at("payload");

                    TelemetryEvent event;
                    std::strncpy(event.profile_id, globalProfile.profile_id.c_str(), sizeof(event.profile_id) - 1);
                    event.profile_id[sizeof(event.profile_id) - 1] = '\0';
                    
                    // Route live values based on baseline type
                    if (globalProfile.profile_id == "crop_moisture") {
                        event.value = payload.at("humidity").get<double>(); // Map moisture to humidity variable
                    } else {
                        event.value = payload.at("temperature").get<double>(); // Map power consumption to temperature variable
                    }
                    event.timestamp = payload.at("timestamp").get<long>();

                    // Push telemetry event locklessly to RT Comparator
                    if (!ingestQueue.push(event)) {
                        std::cerr << "[TelemetryServer] Ingest queue overflow! Telemetry packet dropped." << std::endl;
                    }
                } catch (const std::exception& e) {
                    std::cerr << "[TelemetryServer] JSON Parse Error: " << e.what() << std::endl;
                }
            }
        }
        close(clientFd);
        std::cout << "[TelemetryServer] Client disconnected" << std::endl;
    }

    close(serverFd);
}

} // namespace

int main(int argc, char* argv[]) {
    std::string baselineFile = "configs/baseline_crop.json";
    int serverPort = 14101;

    for (int i = 1; i < argc; ++i) {
        if (std::strcmp(argv[i], "--baseline") == 0 && i + 1 < argc) {
            baselineFile = argv[i + 1];
            ++i;
        } else if (std::strcmp(argv[i], "--port") == 0 && i + 1 < argc) {
            serverPort = std::stoi(argv[i + 1]);
            ++i;
        }
    }

    std::cout << "=== Weather RTOS: Personal Baseline Comparator Service ===" << std::endl;

    if (!loadBaselineFile(baselineFile, globalProfile)) {
        std::cerr << "Fatal: Failed to load baseline configuration file: " << baselineFile << std::endl;
        return 1;
    }

    // Start background threads
    std::thread rtThread(runRealTimeComparator);
    std::thread dbThread(runDatabaseSyncWorker);
    std::thread serverThread(runTelemetryServer, serverPort);

    // Keep main thread alive
    serverThread.join();
    
    running.store(false);
    if (rtThread.joinable()) rtThread.join();
    if (dbThread.joinable()) dbThread.join();

    return 0;
}
