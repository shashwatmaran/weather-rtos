#pragma once

#include <string>
#include <utility>

#include "../protocol/MessageEnvelope.hpp"
#include "../socket/TCPSocket.hpp"

class IBrokerPublisher {
public:
    virtual ~IBrokerPublisher() = default;

    virtual bool publish(const MessageEnvelope& envelope) = 0;
};

class TcpBrokerPublisher final : public IBrokerPublisher {
public:
    TcpBrokerPublisher(std::string host, int port)
        : host_(std::move(host)), port_(port) {}

    bool publish(const MessageEnvelope& envelope) override {
        if (!connected_) {
            connected_ = socket_.connectToServer(host_, port_);
        }

        if (!connected_) {
            return false;
        }

        if (!socket_.sendMessage(envelope_to_json(envelope).dump())) {
            socket_.closeConnection();
            connected_ = false;
            return false;
        }

        return true;
    }

private:
    std::string host_;
    int port_;
    TCPSocket socket_;
    bool connected_{false};
};