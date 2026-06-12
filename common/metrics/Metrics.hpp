#pragma once

#include <atomic>
#include <cstdint>
#include <string>
#include <sstream>
#include <thread>
#include <iostream>

#include <arpa/inet.h>
#include <netinet/in.h>
#include <sys/socket.h>
#include <sys/types.h>
#include <unistd.h>

namespace metrics {

inline std::atomic<uint64_t> messagesProcessed{0};
inline std::atomic<uint64_t> batchesFlushed{0};
inline std::atomic<uint64_t> dbWrites{0};
inline std::atomic<uint64_t> writeErrors{0};
inline std::atomic<uint64_t> backpressureEvents{0};
inline std::atomic<uint64_t> queueDepth{0};
inline std::atomic<uint64_t> regionPartitions{0};
inline std::atomic<uint64_t> ingestionLatencySumMs{0};
inline std::atomic<uint64_t> ingestionLatencyCount{0};

inline std::string gather() {
	std::ostringstream out;
	out << "# HELP weather_messages_processed Total messages processed by writer" << "\n";
	out << "# TYPE weather_messages_processed counter" << "\n";
	out << "weather_messages_processed " << messagesProcessed.load() << "\n";

	out << "# HELP weather_batches_flushed Total batches flushed (DB or outbox)" << "\n";
	out << "# TYPE weather_batches_flushed counter" << "\n";
	out << "weather_batches_flushed " << batchesFlushed.load() << "\n";

	out << "# HELP weather_db_writes Total successful DB batch writes" << "\n";
	out << "# TYPE weather_db_writes counter" << "\n";
	out << "weather_db_writes " << dbWrites.load() << "\n";

	out << "# HELP weather_write_errors Total write errors (DB or outbox)" << "\n";
	out << "# TYPE weather_write_errors counter" << "\n";
	out << "weather_write_errors " << writeErrors.load() << "\n";

	out << "# HELP weather_backpressure_events Total backpressure rejections" << "\n";
	out << "# TYPE weather_backpressure_events counter" << "\n";
	out << "weather_backpressure_events " << backpressureEvents.load() << "\n";

	out << "# HELP weather_queue_depth Current queue depth" << "\n";
	out << "# TYPE weather_queue_depth gauge" << "\n";
	out << "weather_queue_depth " << queueDepth.load() << "\n";

	out << "# HELP weather_region_partitions Number of region partitions in memory" << "\n";
	out << "# TYPE weather_region_partitions gauge" << "\n";
	out << "weather_region_partitions " << regionPartitions.load() << "\n";

	uint64_t sum = ingestionLatencySumMs.load();
	uint64_t count = ingestionLatencyCount.load();
	double avgLatency = count > 0 ? static_cast<double>(sum) / count : 0.0;
	out << "# HELP weather_ingestion_latency_avg_ms Average end-to-end ingestion latency" << "\n";
	out << "# TYPE weather_ingestion_latency_avg_ms gauge" << "\n";
	out << "weather_ingestion_latency_avg_ms " << avgLatency << "\n";

	return out.str();
}

inline void start_http_server(int port = 9100) {
	std::thread([port]() {
		int server_fd = socket(AF_INET, SOCK_STREAM, 0);
		if (server_fd == -1) {
			std::cerr << "[metrics] socket() failed" << std::endl;
			return;
		}

		int opt = 1;
		setsockopt(server_fd, SOL_SOCKET, SO_REUSEADDR, &opt, sizeof(opt));

		sockaddr_in addr{};
		addr.sin_family = AF_INET;
		addr.sin_addr.s_addr = INADDR_ANY;
		addr.sin_port = htons(static_cast<uint16_t>(port));

		if (bind(server_fd, reinterpret_cast<sockaddr*>(&addr), sizeof(addr)) < 0) {
			std::cerr << "[metrics] bind() failed on port " << port << std::endl;
			close(server_fd);
			return;
		}

		if (listen(server_fd, 8) < 0) {
			std::cerr << "[metrics] listen() failed" << std::endl;
			close(server_fd);
			return;
		}

		std::cout << "[metrics] HTTP metrics server listening on port " << port << std::endl;

		while (true) {
			int client = accept(server_fd, nullptr, nullptr);
			if (client < 0) {
				std::this_thread::sleep_for(std::chrono::milliseconds(100));
				continue;
			}

			// Read the request (not parsed fully; only to drain)
			char buf[1024];
			ssize_t n = recv(client, buf, sizeof(buf) - 1, 0);
			(void)n;

			std::string body = gather();
			std::ostringstream resp;
			resp << "HTTP/1.1 200 OK\r\n";
			resp << "Content-Type: text/plain; version=0.0.4\r\n";
			resp << "Content-Length: " << body.size() << "\r\n";
			resp << "Connection: close\r\n\r\n";
			resp << body;

			const std::string out = resp.str();
			send(client, out.c_str(), out.size(), 0);
			close(client);
		}
	}).detach();
}

inline void inc_messages_processed() { messagesProcessed.fetch_add(1); }
inline void inc_batches_flushed() { batchesFlushed.fetch_add(1); }
inline void inc_db_writes() { dbWrites.fetch_add(1); }
inline void inc_write_errors() { writeErrors.fetch_add(1); }
inline void inc_backpressure_events() { backpressureEvents.fetch_add(1); }
inline void set_queue_depth(std::uint64_t depth) { queueDepth.store(depth); }
inline void set_region_partitions(std::uint64_t parts) { regionPartitions.store(parts); }
inline void add_ingestion_latency(uint64_t ms) {
	ingestionLatencySumMs.fetch_add(ms);
	ingestionLatencyCount.fetch_add(1);
}

} // namespace metrics
