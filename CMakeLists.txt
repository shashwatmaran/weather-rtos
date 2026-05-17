cmake_minimum_required(VERSION 3.16)

project(weather_rtos)

set(CMAKE_CXX_STANDARD 20)

find_package(CURL REQUIRED)

# Common socket library
add_library(socket common/socket/TCPSocket.cpp)
target_include_directories(socket PUBLIC ${CMAKE_CURRENT_SOURCE_DIR})

# Collector: South India
add_executable(south_india_collector collectors/south_india/main.cpp)
target_include_directories(south_india_collector PRIVATE ${CMAKE_CURRENT_SOURCE_DIR})
target_link_libraries(south_india_collector socket CURL::libcurl)

# Aggregator: India
add_executable(india_aggregator aggregator/india/main.cpp)
target_include_directories(india_aggregator PRIVATE ${CMAKE_CURRENT_SOURCE_DIR})
target_link_libraries(india_aggregator socket)

# Aggregator: Asia
add_executable(asia_aggregator aggregator/asia/main.cpp)
target_include_directories(asia_aggregator PRIVATE ${CMAKE_CURRENT_SOURCE_DIR})
target_link_libraries(asia_aggregator socket)

# Simulator (legacy)
add_executable(simulator simulator/main.cpp)
target_link_libraries(simulator CURL::libcurl)