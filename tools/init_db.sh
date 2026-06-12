#!/usr/bin/env bash
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
DSN="${TIMESCALEDB_DSN:-host=127.0.0.1 port=5432 dbname=weather_rtos user=weather_rtos password=weather_secret}"

run_sql() {
  local file="$1"
  echo "Applying $(basename "$file")..."
  psql "$DSN" -v ON_ERROR_STOP=1 -f "$file"
}

if ! command -v psql >/dev/null 2>&1; then
  echo "psql not found. Install postgresql-client or run this via docker exec." >&2
  exit 1
fi

run_sql "$ROOT/timescale/schema.sql"
run_sql "$ROOT/timescale/map_phase1.sql"
run_sql "$ROOT/timescale/migrations/005_storage_policies.sql"
run_sql "$ROOT/timescale/migrations/006_ingestion_layers.sql"

echo "Database schema ready."
