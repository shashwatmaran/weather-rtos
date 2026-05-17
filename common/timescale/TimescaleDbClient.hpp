#pragma once

#include <cstdlib>
#include <iostream>
#include <string>

#if __has_include(<libpq-fe.h>)
#include <libpq-fe.h>
#define WEATHER_RTOS_HAS_LIBPQ 1
#elif __has_include(<postgresql/libpq-fe.h>)
#include <postgresql/libpq-fe.h>
#define WEATHER_RTOS_HAS_LIBPQ 1
#else
#define WEATHER_RTOS_HAS_LIBPQ 0
#endif

class TimescaleDbClient {
public:
    TimescaleDbClient() {
        const char* dsn = std::getenv("TIMESCALEDB_DSN");
        const char* connectionString = std::getenv("TIMESCALEDB_CONNECTION_STRING");
        if (dsn != nullptr && *dsn != '\0') {
            connect(dsn);
        } else if (connectionString != nullptr && *connectionString != '\0') {
            connect(connectionString);
        }
    }

    ~TimescaleDbClient() {
#if WEATHER_RTOS_HAS_LIBPQ
        if (connection_ != nullptr) {
            PQfinish(connection_);
            connection_ = nullptr;
        }
#endif
    }

    bool isEnabled() const {
        return enabled_;
    }

    bool isConnected() const {
#if WEATHER_RTOS_HAS_LIBPQ
        return connection_ != nullptr && PQstatus(connection_) == CONNECTION_OK;
#else
        return false;
#endif
    }

    std::string backendName() const {
        return isConnected() ? "TimescaleDB" : "file outbox";
    }

    bool executeBatch(const std::string& sql) {
#if WEATHER_RTOS_HAS_LIBPQ
        if (!isConnected()) {
            return false;
        }

        PGresult* result = PQexec(connection_, sql.c_str());
        if (result == nullptr) {
            std::cerr << "[TimescaleDB] PQexec returned null: " << PQerrorMessage(connection_) << std::endl;
            rollback();
            return false;
        }

        const ExecStatusType status = PQresultStatus(result);
        const bool ok = (status == PGRES_COMMAND_OK) || (status == PGRES_TUPLES_OK);
        if (!ok) {
            std::cerr << "[TimescaleDB] Batch failed: " << PQresultErrorMessage(result) << std::endl;
            PQclear(result);
            rollback();
            return false;
        }

        PQclear(result);
        return true;
#else
        (void)sql;
        return false;
#endif
    }

private:
    void connect(const std::string& conninfo) {
        enabled_ = true;
#if WEATHER_RTOS_HAS_LIBPQ
        connection_ = PQconnectdb(conninfo.c_str());
        if (connection_ == nullptr || PQstatus(connection_) != CONNECTION_OK) {
            std::cerr << "[TimescaleDB] Connection failed: "
                      << (connection_ != nullptr ? PQerrorMessage(connection_) : "unknown error")
                      << std::endl;
            if (connection_ != nullptr) {
                PQfinish(connection_);
                connection_ = nullptr;
            }
        }
#else
        (void)conninfo;
        std::cerr << "[TimescaleDB] libpq is not available at build time, using outbox fallback" << std::endl;
#endif
    }

#if WEATHER_RTOS_HAS_LIBPQ
    void rollback() {
        if (isConnected()) {
            PGresult* result = PQexec(connection_, "ROLLBACK;");
            if (result != nullptr) {
                PQclear(result);
            }
        }
    }

    PGconn* connection_{nullptr};
#endif

    bool enabled_{false};
};