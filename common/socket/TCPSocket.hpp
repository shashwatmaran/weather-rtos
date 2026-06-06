#ifndef TCP_SOCKET_HPP
#define TCP_SOCKET_HPP

#include <string>

class TCPSocket {
public:
    TCPSocket();
    ~TCPSocket();

    bool createServer(int port);
    int acceptClient(int timeoutMs = -1, int wakeFd = -1);
    bool connectToServer(const std::string& host, int port);
    bool sendMessage(const std::string& message);
    int receiveMessage(std::string& message, int timeoutMs = -1);
    int receiveMessage(std::string& message, int timeoutMs, int wakeFd);
    void closeConnection();
    void setSocketFd(int fd);

private:
    int waitForReadable(int fd, int timeoutMs, int wakeFd);
    bool configureSocketOptions(int fd, bool serverSocket);

    int socketFd;
    int clientFd;
};

#endif // TCP_SOCKET_HPP
