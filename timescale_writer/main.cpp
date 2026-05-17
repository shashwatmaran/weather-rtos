#include <atomic>
#include <chrono>
#include <csignal>
#include <cstdlib>
#include <fstream>
#include <iostream>
#include <memory>
#include <thread>

#include <nlohmann/json.hpp>

#include "../common/pipeline/ValidationAggregationConsumerPipeline.hpp"
#include "../common/socket/TCPSocket.hpp"
#include "../common/subscribing/TcpSubscriber.hpp"
#include "../common/timescale/TimescaleBatchWriter.hpp"

using json = nlohmann::json;

std::atomic<bool> running{true};

void handleShutdownSignal(int) {
    running.store(false);
}

int main() {
    std::signal(SIGINT, handleShutdownSignal);
    std::signal(SIGTERM, handleShutdownSignal);

    std::cout << "=== Timescale Writer (Socket-fed prototype) ===" << std::endl;
    std::cout << "Listening on port 13101 and batching to TimescaleDB when configured" << std::endl;
    std::cout << "Set TIMESCALEDB_DSN or TIMESCALEDB_CONNECTION_STRING to enable direct DB writes" << std::endl;
    std::cout << "Otherwise, batches are written to timescale_outbox.sql" << std::endl;

    auto batchWriter = std::make_shared<TimescaleBatchWriter>("timescale_outbox.sql", 2048, 128, std::chrono::milliseconds(1000));

    auto pipeline = std::make_shared<ValidationAggregationConsumerPipeline>(
        "timescale_writer",
        [batchWriter](const MessageEnvelope& envelope) {
            if (!batchWriter->submit(envelope)) {
                std::cerr << "[timescale_writer] Backpressure or duplicate detected for " << envelope.message_id << std::endl;
            }
        }
    );

    std::thread batchThread([&batchWriter]() {
        batchWriter->run(running);
    });

    TcpSubscriber subscriber(13101, pipeline, "timescale_writer_tcp");
    subscriber.run(running);

    running.store(false);
    if (batchThread.joinable()) {
        batchThread.join();
    }

    return 0;
}
