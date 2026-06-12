#!/usr/bin/env bash
# Start the full weather RTOS ingestion pipeline (non-blocking).
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

export WEATHER_RTOS_HOST="${WEATHER_RTOS_HOST:-127.0.0.1}"
export TIMESCALEDB_DSN="${TIMESCALEDB_DSN:-host=127.0.0.1 port=5432 dbname=weather_rtos user=weather_rtos password=weather_secret}"
export LOGDIR="${LOGDIR:-$ROOT/logs}"
mkdir -p "$LOGDIR"

if [ ! -x build/timescale_writer ]; then
  echo "Build binaries first: cmake --build build -j4" >&2
  exit 1
fi

start() {
  local name="$1"
  shift
  echo "Starting $name..."
  "$@" > "$LOGDIR/${name}.log" 2>&1 &
  echo "$name pid=$!"
}

start timescale_writer ./build/timescale_writer
sleep 1

start global_sink ./build/hierarchical_aggregator global_sink
sleep 1

start asia_continent ./build/hierarchical_aggregator asia_continent
start europe_continent ./build/hierarchical_aggregator europe_continent
start americas_continent ./build/hierarchical_aggregator americas_continent
sleep 1

start asia_regional ./build/hierarchical_aggregator asia_regional
start europe_regional ./build/hierarchical_aggregator europe_regional
start americas_regional ./build/hierarchical_aggregator americas_regional
sleep 1

start south_india ./build/regional_collector south_india
start north_india ./build/regional_collector north_india
start europe ./build/regional_collector europe
start americas ./build/regional_collector americas

echo ""
echo "Ingestion pipeline started. Logs: $LOGDIR"
echo "Writer metrics: http://127.0.0.1:9100/metrics"
echo "Stop with: pkill -f 'build/(timescale_writer|hierarchical_aggregator|regional_collector)'"
