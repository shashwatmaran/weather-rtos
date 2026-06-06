#include "TCPSocket.hpp"
#include <iostream>
#include <cstring>
#include <unistd.h>
#include <sys/socket.h>
#include <netinet/in.h>
#include <arpa/inet.h>
#include <cerrno>
#include <fcntl.h>
#include <poll.h>
#include <sys/epoll.h>
#include <sys/eventfd.h>
#include <sys/timerfd.h>
#include <netinet/tcp.h>

TCPSocket::TCPSocket() : socketFd(-1), clientFd(-1) {}

TCPSocket::~TCPSocket() {
    closeConnection();
}

void TCPSocket::closeConnection() {
    if (clientFd != -1) {
        close(clientFd);
        clientFd = -1;
    }
    if (socketFd != -1) {
        close(socketFd);
        socketFd = -1;
    }
}

bool TCPSocket::configureSocketOptions(int fd, bool serverSocket) {
    int opt = 1;
    if (setsockopt(fd, SOL_SOCKET, SO_REUSEADDR, &opt, sizeof(opt)) < 0) {
        std::cerr << "Error setting SO_REUSEADDR" << std::endl;
        return false;
    }

#ifdef SO_REUSEPORT
    if (serverSocket) {
        if (setsockopt(fd, SOL_SOCKET, SO_REUSEPORT, &opt, sizeof(opt)) < 0) {
            std::cerr << "Error setting SO_REUSEPORT" << std::endl;
            return false;
        }
    }
#endif

    int bufferSize = 1 << 20;
    setsockopt(fd, SOL_SOCKET, SO_RCVBUF, &bufferSize, sizeof(bufferSize));
    setsockopt(fd, SOL_SOCKET, SO_SNDBUF, &bufferSize, sizeof(bufferSize));

    if (!serverSocket) {
        setsockopt(fd, IPPROTO_TCP, TCP_NODELAY, &opt, sizeof(opt));
    }

    return true;
}

int TCPSocket::waitForReadable(int fd, int timeoutMs, int wakeFd) {
    if (fd < 0) {
        return -1;
    }

#ifdef __linux__
    int epollFd = epoll_create1(EPOLL_CLOEXEC);
    if (epollFd >= 0) {
        auto addFd = [epollFd](int trackedFd, uint32_t events) {
            if (trackedFd < 0) {
                return true;
            }
            struct epoll_event event{};
            event.events = events;
            event.data.fd = trackedFd;
            return epoll_ctl(epollFd, EPOLL_CTL_ADD, trackedFd, &event) == 0;
        };

        int timerFd = -1;
        if (timeoutMs >= 0) {
            timerFd = timerfd_create(CLOCK_MONOTONIC, TFD_CLOEXEC | TFD_NONBLOCK);
            if (timerFd >= 0) {
                struct itimerspec spec{};
                spec.it_value.tv_sec = timeoutMs / 1000;
                spec.it_value.tv_nsec = static_cast<long>(timeoutMs % 1000) * 1000000L;
                if (timerfd_settime(timerFd, 0, &spec, nullptr) < 0) {
                    close(timerFd);
                    close(epollFd);
                    return -1;
                }
            }
        }

        if (!addFd(fd, EPOLLIN) || !addFd(wakeFd, EPOLLIN) || !addFd(timerFd, EPOLLIN)) {
            if (timerFd >= 0) {
                close(timerFd);
            }
            close(epollFd);
            return -1;
        }

        struct epoll_event events[3];
        int waitResult = epoll_wait(epollFd, events, 3, timeoutMs < 0 ? -1 : -1);
        if (waitResult < 0) {
            if (errno != EINTR) {
                std::cerr << "Error waiting for socket readiness" << std::endl;
            }
            if (timerFd >= 0) {
                close(timerFd);
            }
            close(epollFd);
            return -1;
        }

        for (int i = 0; i < waitResult; ++i) {
            if (events[i].data.fd == timerFd) {
                uint64_t expired = 0;
                if (timerFd >= 0) {
                    read(timerFd, &expired, sizeof(expired));
                    close(timerFd);
                }
                close(epollFd);
                return 0;
            }
            if (events[i].data.fd == wakeFd) {
                uint64_t ignored = 0;
                read(wakeFd, &ignored, sizeof(ignored));
                if (timerFd >= 0) {
                    close(timerFd);
                }
                close(epollFd);
                return -2;
            }
            if (events[i].data.fd == fd) {
                if (timerFd >= 0) {
                    close(timerFd);
                }
                close(epollFd);
                return 1;
            }
        }

        if (timerFd >= 0) {
            close(timerFd);
        }
        close(epollFd);
        return -1;
    }
#endif

    struct pollfd pfds[2];
    nfds_t nfds = 1;
    pfds[0].fd = fd;
    pfds[0].events = POLLIN;
    if (wakeFd >= 0) {
        pfds[1].fd = wakeFd;
        pfds[1].events = POLLIN;
        nfds = 2;
    }

    int pollResult = poll(pfds, nfds, timeoutMs);
    if (pollResult == 0) {
        return 0;
    }
    if (pollResult < 0) {
        std::cerr << "Error waiting for socket readiness" << std::endl;
        return -1;
    }

    if (wakeFd >= 0 && (pfds[1].revents & POLLIN)) {
        uint64_t ignored = 0;
        read(wakeFd, &ignored, sizeof(ignored));
        return -2;
    }

    return (pfds[0].revents & POLLIN) ? 1 : -1;
}

bool TCPSocket::createServer(int port) {
    socketFd = socket(AF_INET, SOCK_STREAM, 0);
    if (socketFd < 0) {
        std::cerr << "Error creating socket" << std::endl;
        return false;
    }

    if (!configureSocketOptions(socketFd, true)) {
        closeConnection();
        return false;
    }

    struct sockaddr_in addr;
    addr.sin_family = AF_INET;
    addr.sin_addr.s_addr = INADDR_ANY;
    addr.sin_port = htons(port);

    if (bind(socketFd, (struct sockaddr*)&addr, sizeof(addr)) < 0) {
        std::cerr << "Error binding socket" << std::endl;
        return false;
    }

    if (listen(socketFd, 16) < 0) {
        std::cerr << "Error listening on socket" << std::endl;
        return false;
    }

    std::cout << "Server listening on port " << port << std::endl;
    return true;
}

int TCPSocket::acceptClient(int timeoutMs, int wakeFd) {
    if (socketFd < 0) {
        std::cerr << "No listening socket available" << std::endl;
        return -1;
    }

    int readiness = waitForReadable(socketFd, timeoutMs, wakeFd);
    if (readiness == 0) {
        return 0;
    }
    if (readiness == -2) {
        return -2;
    }
    if (readiness < 0) {
        return -1;
    }

    struct sockaddr_in clientAddr;
    socklen_t clientAddrLen = sizeof(clientAddr);

    clientFd = accept4(socketFd, (struct sockaddr*)&clientAddr, &clientAddrLen, SOCK_CLOEXEC);
    if (clientFd < 0) {
        std::cerr << "Error accepting client" << std::endl;
        return -1;
    }

    configureSocketOptions(clientFd, false);

    std::cout << "Client connected from " << inet_ntoa(clientAddr.sin_addr) << std::endl;
    return clientFd;
}

bool TCPSocket::connectToServer(const std::string& host, int port) {
    closeConnection();

    socketFd = socket(AF_INET, SOCK_STREAM, 0);
    if (socketFd < 0) {
        std::cerr << "Error creating socket" << std::endl;
        return false;
    }

    if (!configureSocketOptions(socketFd, false)) {
        closeConnection();
        return false;
    }

    struct sockaddr_in addr;
    addr.sin_family = AF_INET;
    addr.sin_port = htons(port);

    if (inet_pton(AF_INET, host.c_str(), &addr.sin_addr) <= 0) {
        std::cerr << "Invalid address: " << host << std::endl;
        return false;
    }

    if (connect(socketFd, (struct sockaddr*)&addr, sizeof(addr)) < 0) {
        std::cerr << "Error connecting to server" << std::endl;
        return false;
    }

    std::cout << "Connected to server at " << host << ":" << port << std::endl;
    return true;
}

bool TCPSocket::sendMessage(const std::string& message) {
    int fd = (clientFd != -1) ? clientFd : socketFd;
    if (fd < 0) {
        std::cerr << "No active connection" << std::endl;
        return false;
    }

    std::string framedMessage = message + "\n";
    ssize_t sent = send(fd, framedMessage.c_str(), framedMessage.length(), 0);
    if (sent < 0) {
        std::cerr << "Error sending message" << std::endl;
        return false;
    }

    return true;
}

int TCPSocket::receiveMessage(std::string& message, int timeoutMs) {
    return receiveMessage(message, timeoutMs, -1);
}

int TCPSocket::receiveMessage(std::string& message, int timeoutMs, int wakeFd) {
    int fd = (clientFd != -1) ? clientFd : socketFd;
    if (fd < 0) {
        std::cerr << "No active connection" << std::endl;
        return -1;
    }

    message.clear();
    char buffer[1];

    while (true) {
        int readiness = waitForReadable(fd, timeoutMs, wakeFd);
        if (readiness == 0) {
            return 0;
        }
        if (readiness == -2) {
            return -2;
        }
        if (readiness < 0) {
            return -1;
        }

        ssize_t received = recv(fd, buffer, 1, 0);
        if (received < 0) {
            if (errno == EINTR) {
                continue;
            }
            std::cerr << "Error receiving message" << std::endl;
            return -1;
        }
        if (received == 0) {
            std::cout << "Connection closed" << std::endl;
            return -1;
        }
        
        if (buffer[0] == '\n') {
            break;
        }
        message += buffer[0];
    }

    return 1;
}

void TCPSocket::setSocketFd(int fd) {
    socketFd = fd;
}
