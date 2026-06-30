#!/bin/bash
set -e
echo "Starting Weather RTOS stack..."

echo "1. Starting map_query_api on port 8091..."
TIMESCALEDB_DSN="host=127.0.0.1 port=5432 dbname=weather_rtos user=weather_rtos password=weather_secret" nohup ./build/map_query_api 8091 > map_query_api.log 2>&1 &
echo $! > api.pid

echo "2. Starting timescale_writer (Data Ingestion)..."
nohup ./build/timescale_writer > timescale_writer_demo.log 2>&1 &
echo $! > writer.pid
sleep 2

echo "3. Starting simulator (Data Generation)..."
nohup ./build/simulator > simulator_demo.log 2>&1 &
echo $! > simulator.pid

echo "4. Starting Weather Dashboard Frontend (port 5174)..."
cd apps/weather_dashboard
nohup python3 -m http.server 5174 > dashboard.log 2>&1 &
echo $! > ../../dashboard.pid
cd ../..

echo "All services started gracefully."
