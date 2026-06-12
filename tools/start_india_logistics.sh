#!/usr/bin/env bash
# Start the High-Density India Logistics Ingestion Pipeline.
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

export LOGDIR="${LOGDIR:-$ROOT/logs_india_logistics}"
mkdir -p "$LOGDIR"

TOPOLOGY="configs/india_high_density_logistics.json"

echo "=== India High-Density Logistics Ingestion ==="
echo "Topology: $TOPOLOGY"

# 1. Start Timescale Writer
echo "Starting timescale_writer..."
./build/timescale_writer > "$LOGDIR/timescale_writer.log" 2>&1 &
sleep 1

# 2. Start Aggregators based on topology
echo "Starting India Mega Aggregator..."
./build/hierarchical_aggregator india_mega_aggregator "$TOPOLOGY" > "$LOGDIR/india_aggregator.log" 2>&1 &
sleep 1

echo "Starting India Logistics Sink..."
./build/hierarchical_aggregator india_logistics_sink "$TOPOLOGY" > "$LOGDIR/india_sink.log" 2>&1 &
sleep 1

# 3. Start High-Density Collectors
echo "Starting Regional Collectors (South, North, West)..."
./build/regional_collector south_india_high_density "$TOPOLOGY" > "$LOGDIR/south_india.log" 2>&1 &
./build/regional_collector north_india_high_density "$TOPOLOGY" > "$LOGDIR/north_india.log" 2>&1 &
./build/regional_collector west_india_high_density "$TOPOLOGY" > "$LOGDIR/west_india.log" 2>&1 &

echo ""
echo "India Logistics Pipeline started. Logs: $LOGDIR"
echo "Monitor with: tail -f $LOGDIR/timescale_writer.log"
