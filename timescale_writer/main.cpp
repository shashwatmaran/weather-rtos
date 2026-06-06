#include <atomic>
#include <chrono>
#include <csignal>
#include <cstdlib>
#include <fstream>
#include <iostream>
#include <memory>
#include <thread>

#include <sys/eventfd.h>
#include <unistd.h>

#include <nlohmann/json.hpp>

#include "../common/pipeline/ValidationAggregationConsumerPipeline.hpp"
#include "../common/socket/TCPSocket.hpp"
#include "../common/subscribing/TcpSubscriber.hpp"
#include "../common/timescale/AsyncQueueWriter.hpp"
#include "../common/metrics/Metrics.hpp"

using json = nlohmann::json;

std::atomic<bool> running{true};
int shutdownEventFd = -1;

void handleShutdownSignal(int) {
    running.store(false);
    if (shutdownEventFd >= 0) {
        const uint64_t signalValue = 1;
        write(shutdownEventFd, &signalValue, sizeof(signalValue));
    }
}

int main() {
    std::signal(SIGINT, handleShutdownSignal);
    std::signal(SIGTERM, handleShutdownSignal);

    std::cout << "=== Timescale Writer (Tier 2: Async Queue) ===" << std::endl;
    std::cout << "Queue-based architecture with region partitioning" << std::endl;
    std::cout << "Auto-detecting local TimescaleDB..." << std::endl;

    // Start metrics endpoint for Prometheus scraping
    metrics::start_http_server(9100);
    std::cout << "Metrics HTTP endpoint started on port 9100" << std::endl;

    shutdownEventFd = eventfd(0, EFD_CLOEXEC | EFD_NONBLOCK);
    if (shutdownEventFd < 0) {
        std::cerr << "[timescale_writer] Failed to create shutdown eventfd" << std::endl;
    }

    // Configure Tier 2: bounded queue + region partitioning
    AsyncQueueWriter::Config queueConfig;
    queueConfig.maxQueueSize = 4096;       // Keep memory bounded
    queueConfig.batchSize = 250;           // Lower latency than giant flushes
    queueConfig.flushInterval = std::chrono::milliseconds(500);
    queueConfig.outboxPath = "timescale_outbox.sql";
    queueConfig.maxRetries = 3;
    queueConfig.retryDelay = std::chrono::milliseconds(100);

    auto writer = std::make_shared<AsyncQueueWriter>(queueConfig);

    auto pipeline = std::make_shared<ValidationAggregationConsumerPipeline>(
        "timescale_writer",
        [writer](const MessageEnvelope& envelope) {
            if (!writer->submit(envelope)) {
                std::cerr << "[timescale_writer] Queue full for " << envelope.message_id << std::endl;
            }
        }
    );

    // Start socket subscriber on a separate thread (receives data)
    std::thread subscriberThread([&pipeline]() {
        TcpSubscriber subscriber(13101, pipeline, "timescale_writer_tcp");
        subscriber.run(running, shutdownEventFd);
    });

    // Run writer on main thread (manages queue + batch flushing)
    writer->run(running);

    // Wait for subscriber thread to finish (it waits for running signal)
    if (subscriberThread.joinable()) {
        subscriberThread.join();
    }

    if (shutdownEventFd >= 0) {
        close(shutdownEventFd);
        shutdownEventFd = -1;
    }

    // Print final metrics
    const auto& metrics = writer->getMetrics();
    std::cout << "\n=== Final Statistics ===" << std::endl;
    std::cout << "Messages processed: " << metrics.messagesProcessed << std::endl;
    std::cout << "Batches flushed: " << metrics.batchesFlushed << std::endl;
    std::cout << "Write errors: " << metrics.writeErrors << std::endl;
    std::cout << "Backpressure events: " << metrics.backpressureEvents << std::endl;
    std::cout << "Final queue depth: " << writer->getQueueDepth() << std::endl;

    return 0;
}
