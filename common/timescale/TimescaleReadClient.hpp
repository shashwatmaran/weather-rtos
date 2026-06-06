#pragma once

#include <algorithm>
#include <cerrno>
#include <cstdlib>
#include <cstdio>
#include <filesystem>
#include <fstream>
#include <iostream>
#include <optional>
#include <sstream>
#include <string>

#include <sys/wait.h>

#include <nlohmann/json.hpp>

#if __has_include(<libpq-fe.h>)
#include <libpq-fe.h>
#define WEATHER_RTOS_READ_HAS_LIBPQ 1
#elif __has_include(<postgresql/libpq-fe.h>)
#include <postgresql/libpq-fe.h>
#define WEATHER_RTOS_READ_HAS_LIBPQ 1
#else
#define WEATHER_RTOS_READ_HAS_LIBPQ 0
#endif

using json = nlohmann::json;

class TimescaleReadClient {
public:
    TimescaleReadClient() {
        const char* dsn = std::getenv("TIMESCALEDB_DSN");
        const char* connectionString = std::getenv("TIMESCALEDB_CONNECTION_STRING");

        if (dsn != nullptr && *dsn != '\0') {
            connectionString_ = dsn;
        } else if (connectionString != nullptr && *connectionString != '\0') {
            connectionString_ = connectionString;
        }
    }

    bool isEnabled() const {
        return !connectionString_.empty();
    }

    std::optional<json> queryJson(const std::string& sql) const {
        if (connectionString_.empty()) {
            return std::nullopt;
        }

#if WEATHER_RTOS_READ_HAS_LIBPQ
        PGconn* connection = PQconnectdb(connectionString_.c_str());
        if (connection == nullptr || PQstatus(connection) != CONNECTION_OK) {
            if (connection != nullptr) {
                PQfinish(connection);
            }
            return std::nullopt;
        }

        PGresult* result = PQexec(connection, sql.c_str());
        if (result == nullptr) {
            PQfinish(connection);
            return std::nullopt;
        }

        const ExecStatusType status = PQresultStatus(result);
        if (status != PGRES_TUPLES_OK || PQntuples(result) < 1 || PQnfields(result) < 1) {
            PQclear(result);
            PQfinish(connection);
            return std::nullopt;
        }

        const char* value = PQgetvalue(result, 0, 0);
        std::optional<json> parsed;
        try {
            parsed = json::parse(value != nullptr ? value : "[]");
        } catch (...) {
            parsed = std::nullopt;
        }

        PQclear(result);
        PQfinish(connection);
        return parsed;
#else
        return runPsqlQuery(sql);
#endif
    }

    std::optional<std::string> queryScalar(const std::string& sql) const {
        if (connectionString_.empty()) {
            return std::nullopt;
        }

#if WEATHER_RTOS_READ_HAS_LIBPQ
        PGconn* connection = PQconnectdb(connectionString_.c_str());
        if (connection == nullptr || PQstatus(connection) != CONNECTION_OK) {
            if (connection != nullptr) {
                PQfinish(connection);
            }
            return std::nullopt;
        }

        PGresult* result = PQexec(connection, sql.c_str());
        if (result == nullptr) {
            PQfinish(connection);
            return std::nullopt;
        }

        const ExecStatusType status = PQresultStatus(result);
        if (status != PGRES_TUPLES_OK || PQntuples(result) < 1 || PQnfields(result) < 1) {
            PQclear(result);
            PQfinish(connection);
            return std::nullopt;
        }

        const char* value = PQgetvalue(result, 0, 0);
        std::optional<std::string> parsed;
        if (value != nullptr) {
            parsed = std::string(value);
        } else {
            parsed = std::nullopt;
        }

        PQclear(result);
        PQfinish(connection);
        return parsed;
#else
        return runPsqlScalar(sql);
#endif
    }

private:
    static std::string shellEscape(const std::string& value) {
        std::string escaped = "'";
        for (char ch : value) {
            if (ch == '\'') {
                escaped += "'\\''";
            } else {
                escaped.push_back(ch);
            }
        }
        escaped.push_back('\'');
        return escaped;
    }

    std::optional<json> runPsqlQuery(const std::string& sql) const {
        namespace fs = std::filesystem;
        const fs::path tempDir = fs::temp_directory_path();
        const fs::path sqlPath = tempDir / "weather_rtos_map_query.sql";

        {
            std::ofstream sqlFile(sqlPath);
            if (!sqlFile.is_open()) {
                return std::nullopt;
            }
            sqlFile << sql << std::endl;
        }

        const std::string command = "psql -X -q -t -A -v ON_ERROR_STOP=1 -d " +
                                    shellEscape(connectionString_) +
                                    " -f " + shellEscape(sqlPath.string()) +
                                    " 2>/dev/null";

        FILE* pipe = popen(command.c_str(), "r");
        if (pipe == nullptr) {
            std::error_code ec;
            fs::remove(sqlPath, ec);
            return std::nullopt;
        }

        std::string output;
        char buffer[4096];
        while (fgets(buffer, sizeof(buffer), pipe) != nullptr) {
            output += buffer;
        }

        const int status = pclose(pipe);
        std::error_code ec;
        fs::remove(sqlPath, ec);
        if (status == -1 || !WIFEXITED(status) || WEXITSTATUS(status) != 0) {
            return std::nullopt;
        }

        output.erase(std::remove(output.begin(), output.end(), '\n'), output.end());
        output.erase(std::remove(output.begin(), output.end(), '\r'), output.end());

        if (output.empty()) {
            return std::nullopt;
        }

        try {
            return json::parse(output);
        } catch (...) {
            return std::nullopt;
        }
    }

    std::optional<std::string> runPsqlScalar(const std::string& sql) const {
        namespace fs = std::filesystem;
        const fs::path tempDir = fs::temp_directory_path();
        const fs::path sqlPath = tempDir / "weather_rtos_map_query.sql";

        {
            std::ofstream sqlFile(sqlPath);
            if (!sqlFile.is_open()) {
                return std::nullopt;
            }
            sqlFile << sql << std::endl;
        }

        const std::string command = "psql -X -q -t -A -v ON_ERROR_STOP=1 -d " +
                                    shellEscape(connectionString_) +
                                    " -f " + shellEscape(sqlPath.string()) +
                                    " 2>/dev/null";

        FILE* pipe = popen(command.c_str(), "r");
        if (pipe == nullptr) {
            std::error_code ec;
            fs::remove(sqlPath, ec);
            return std::nullopt;
        }

        std::string output;
        char buffer[4096];
        while (fgets(buffer, sizeof(buffer), pipe) != nullptr) {
            output += buffer;
        }

        const int status = pclose(pipe);
        std::error_code ec;
        fs::remove(sqlPath, ec);
        if (status == -1 || !WIFEXITED(status) || WEXITSTATUS(status) != 0) {
            return std::nullopt;
        }

        output.erase(std::remove(output.begin(), output.end(), '\n'), output.end());
        output.erase(std::remove(output.begin(), output.end(), '\r'), output.end());

        if (output.empty()) {
            return std::nullopt;
        }

        return output;
    }

    std::string connectionString_;
};
