#include <iostream>
#include <thread>
#include <atomic>
#include <csignal>
#include <vector>
#include <memory>
#include <nlohmann/json.hpp>
#include "../../common/pipeline/ValidationAggregationConsumerPipeline.hpp"
#include "../../common/protocol/MessageEnvelope.hpp"
#include "../../common/socket/TCPSocket.hpp"

using json = nlohmann::json;

std::atomic<bool> running{true};

void handleShutdownSignal(int) {
    running.store(false);
}

// Listener thread - accepts connections and receives envelopes from the regional gateway
void listenerThread() {
    TCPSocket serverSocket;
    
    if (!serverSocket.createServer(9201)) {
        std::cerr << "Failed to create server on port 9201" << std::endl;
        return;
    }

    std::vector<std::thread> receiveThreads;
    auto pipeline = std::make_shared<ValidationAggregationConsumerPipeline>("asia_consumer");

    while (running.load()) {
        int clientFd = serverSocket.acceptClient(1000);
        if (clientFd == 0) {
            continue;
        }
        if (clientFd < 0) {
            if (!running.load()) {
                break;
            }
            std::cerr << "Failed to accept client" << std::endl;
            continue;
        }

        receiveThreads.emplace_back([clientFd, pipeline]() {
            TCPSocket clientSocket;
            clientSocket.setSocketFd(clientFd);
            std::string message;

            while (running.load()) {
                int status = clientSocket.receiveMessage(message, 1000);
                if (status == 0) {
                    continue;
                }
                if (status < 0) {
                    break;
                }

                try {
                    MessageEnvelope envelope = envelope_from_json(json::parse(message));
                    if (!pipeline->consume(envelope)) {
                        continue;
                    }

                } catch (const std::exception& e) {
                    std::cerr << "[Asia Consumer] Envelope parse error: " << e.what() << std::endl;
                }
            }
        });
    }

    for (auto& receiveThread : receiveThreads) {
        if (receiveThread.joinable()) {
            receiveThread.join();
        }
    }
}

int main() {
    std::signal(SIGINT, handleShutdownSignal);
    std::signal(SIGTERM, handleShutdownSignal);

    std::cout << "=== Asia Validation/Aggregation Consumer (Port 9201) ===" << std::endl;
    std::cout << "Consuming canonical envelopes from the regional gateway..." << std::endl;

    // Create listener thread
    std::thread listener(listenerThread);

    listener.join();

    return 0;
}
