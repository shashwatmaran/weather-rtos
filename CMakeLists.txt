cmake_minimum_required(VERSION 3.16)

project(weather_rtos)

set(CMAKE_CXX_STANDARD 20)

find_package(CURL REQUIRED)

find_path(POSTGRESQL_INCLUDE_DIR libpq-fe.h
	PATHS /usr/include/postgresql /usr/local/include/postgresql)

find_library(POSTGRESQL_LIBRARY pq
	PATHS /usr/lib /usr/lib64 /usr/lib/x86_64-linux-gnu /usr/local/lib)

# Common socket library
add_library(socket common/socket/TCPSocket.cpp)
target_include_directories(socket PUBLIC ${CMAKE_CURRENT_SOURCE_DIR})

# Regional Collector (multi-city, topology-driven)
add_executable(regional_collector collectors/regional/main.cpp)
target_include_directories(regional_collector PRIVATE ${CMAKE_CURRENT_SOURCE_DIR})
target_link_libraries(regional_collector socket CURL::libcurl)

# Hierarchical Aggregator (regional/continent/global, topology-driven)
add_executable(hierarchical_aggregator aggregator/hierarchical/main.cpp)
target_include_directories(hierarchical_aggregator PRIVATE ${CMAKE_CURRENT_SOURCE_DIR})
target_link_libraries(hierarchical_aggregator socket)

# Timescale writer (socket-fed prototype writer)
add_executable(timescale_writer timescale_writer/main.cpp)
target_include_directories(timescale_writer PRIVATE ${CMAKE_CURRENT_SOURCE_DIR})
target_link_libraries(timescale_writer socket)

if (POSTGRESQL_INCLUDE_DIR AND POSTGRESQL_LIBRARY)
	target_include_directories(timescale_writer PRIVATE ${POSTGRESQL_INCLUDE_DIR})
	target_link_libraries(timescale_writer ${POSTGRESQL_LIBRARY})
	target_compile_definitions(timescale_writer PRIVATE WEATHER_RTOS_HAS_LIBPQ=1)
endif()

# Map query API (Phase 1 read path scaffold)
add_executable(map_query_api services/map_query_api/main.cpp)
target_include_directories(map_query_api PRIVATE ${CMAKE_CURRENT_SOURCE_DIR})
target_link_libraries(map_query_api socket)

find_path(POSTGRESQL_INCLUDE_DIR libpq-fe.h
    PATHS /usr/include /usr/include/postgresql /usr/local/include
    PATH_SUFFIXES postgresql)
find_library(POSTGRESQL_LIBRARY pq
    PATHS /usr/lib /usr/lib/x86_64-linux-gnu /usr/local/lib)

if (POSTGRESQL_INCLUDE_DIR AND POSTGRESQL_LIBRARY)
	message(STATUS "Found libpq: ${POSTGRESQL_LIBRARY} (include: ${POSTGRESQL_INCLUDE_DIR})")
	target_include_directories(map_query_api PRIVATE ${POSTGRESQL_INCLUDE_DIR})
	target_link_libraries(map_query_api ${POSTGRESQL_LIBRARY})
	target_compile_definitions(map_query_api PRIVATE WEATHER_RTOS_HAS_LIBPQ=1)
else()
	message(STATUS "libpq not found — map_query_api will use psql fallback")
endif()

# Simulator (legacy)
add_executable(simulator simulator/main.cpp)
target_include_directories(simulator PRIVATE ${CMAKE_CURRENT_SOURCE_DIR})
target_link_libraries(simulator socket CURL::libcurl)

# RTOS Benchmarking and Validation
add_executable(rt_bench tools/rt_bench.cpp)
target_include_directories(rt_bench PRIVATE ${CMAKE_CURRENT_SOURCE_DIR})
target_link_libraries(rt_bench pthread)

# Personal Comparator (Real-time baseline comparison service)
add_executable(personal_comparator services/personal_comparator/main.cpp)
target_include_directories(personal_comparator PRIVATE ${CMAKE_CURRENT_SOURCE_DIR})
target_link_libraries(personal_comparator socket)

if (POSTGRESQL_INCLUDE_DIR AND POSTGRESQL_LIBRARY)
	target_include_directories(personal_comparator PRIVATE ${POSTGRESQL_INCLUDE_DIR})
	target_link_libraries(personal_comparator ${POSTGRESQL_LIBRARY})
	target_compile_definitions(personal_comparator PRIVATE WEATHER_RTOS_HAS_LIBPQ=1)
endif()