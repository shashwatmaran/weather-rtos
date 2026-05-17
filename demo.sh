#!/bin/bash

# Global Weather RTOS Demo - Tree Topology
# This script launches a hierarchical weather collection system with:
#   - 4 regional collectors (South India, North India, Europe, Americas)
#   - 3 regional aggregators (Asia, Europe, Americas)  
#   - 3 continent aggregators (Asia, Europe, Americas)
#   - 1 global aggregator
#
# Uses in-process broker for message passing, so no external Kafka/NATS needed.
# Kill with Ctrl+C to shut everything down.

set -e

cd "$(dirname "$0")"

WEATHER_RTOS_HOST="${WEATHER_RTOS_HOST:-127.0.0.1}"

if [ ! -d build ]; then
    echo "Error: build directory not found. Run 'cmake --build build -j 4' first."
    exit 1
fi

echo "=========================================="
echo "Global Weather RTOS - Tree Topology Demo"
echo "=========================================="
echo ""
echo "Topology:"
echo "  Cities (Collectors)"
echo "    ├─ South India: Bangalore, Hyderabad"
echo "    ├─ North India: Delhi, Mumbai"
echo "    ├─ Europe: Paris, London"
echo "    └─ Americas: New York, Los Angeles"
echo ""
echo "  ↓"
echo "  Regional Aggregators"
echo "    ├─ Asia Regional (consumes south_india_events, north_india_events)"
echo "    ├─ Europe Regional (consumes europe_events)"
echo "    └─ Americas Regional (consumes americas_events)"
echo ""
echo "  ↓"
echo "  Continent Aggregators"
echo "    ├─ Asia Continent (consumes asia_regional_events)"
echo "    ├─ Europe Continent (consumes europe_regional_events)"
echo "    └─ Americas Continent (consumes americas_regional_events)"
echo ""
echo "  ↓"
echo "  Global Aggregator (consumes all continent events)"
echo ""
echo "=========================================="
echo ""
echo "Starting components..."
echo ""
echo "TCP host: $WEATHER_RTOS_HOST"
echo "Set WEATHER_RTOS_HOST to run the topology against another machine on your LAN."
echo ""

# Create a temporary directory for logs
LOGDIR="/tmp/weather-rtos-demo"
mkdir -p "$LOGDIR"

# Trap to kill all background processes on exit
trap 'echo "Shutting down all processes..."; kill $(jobs -p) 2>/dev/null || true' EXIT INT TERM

# Start the downstream chain first so upstream publishers can connect cleanly.
echo "[1/12] Starting Timescale Writer..."
./build/timescale_writer > "$LOGDIR/timescale_writer.log" 2>&1 &

# Give writer time to start
sleep 1

echo "[2/12] Starting Global Aggregator..."
./build/hierarchical_aggregator global_sink > "$LOGDIR/global.log" 2>&1 &

# Give global aggregator time to start
sleep 1

echo "[3/12] Starting Asia Continent Aggregator..."
./build/hierarchical_aggregator asia_continent > "$LOGDIR/asia_continent.log" 2>&1 &

echo "[4/12] Starting Europe Continent Aggregator..."
./build/hierarchical_aggregator europe_continent > "$LOGDIR/europe_continent.log" 2>&1 &

echo "[5/12] Starting Americas Continent Aggregator..."
./build/hierarchical_aggregator americas_continent > "$LOGDIR/americas_continent.log" 2>&1 &

# Give continent aggregators time to start
sleep 1

echo "[6/12] Starting Asia Regional Aggregator..."
./build/hierarchical_aggregator asia_regional > "$LOGDIR/asia_regional.log" 2>&1 &

echo "[7/12] Starting Europe Regional Aggregator..."
./build/hierarchical_aggregator europe_regional > "$LOGDIR/europe_regional.log" 2>&1 &

echo "[8/12] Starting Americas Regional Aggregator..."
./build/hierarchical_aggregator americas_regional > "$LOGDIR/americas_regional.log" 2>&1 &

# Give regional aggregators time to start
sleep 1

echo "[9/12] Starting South India Collector..."
./build/regional_collector south_india > "$LOGDIR/south_india.log" 2>&1 &

echo "[10/12] Starting North India Collector..."
./build/regional_collector north_india > "$LOGDIR/north_india.log" 2>&1 &

echo "[11/12] Starting Europe Collector..."
./build/regional_collector europe > "$LOGDIR/europe.log" 2>&1 &

echo "[12/12] Starting Americas Collector..."
./build/regional_collector americas > "$LOGDIR/americas.log" 2>&1 &

# Give collectors time to start
sleep 1

echo ""
echo "=========================================="
echo "All components started!"
echo "Logs: $LOGDIR"
echo ""
echo "Tailing aggregator outputs (Ctrl+C to exit):"
echo "=========================================="
echo ""

# Follow the global aggregator log (doesn't exist yet, but we can watch regional)
tail -f "$LOGDIR"/*.log &

# Wait for all background processes
wait
