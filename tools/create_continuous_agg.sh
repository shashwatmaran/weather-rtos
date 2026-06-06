#!/usr/bin/env bash
set -euo pipefail

# Usage: TIMESCALEDB_DSN='host=... port=... dbname=... user=... password=...' ./tools/create_continuous_agg.sh
DSN=${TIMESCALEDB_DSN:-$(grep -m1 "TIMESCALEDB_DSN" -s demo.sh | cut -d'=' -f2- | tr -d '"')}
if [ -z "$DSN" ]; then
  echo "TIMESCALEDB_DSN not set; export it or configure demo.sh" >&2
  exit 2
fi

echo "Applying continuous aggregate migration..."
psql "$DSN" -f timescale/migrations/007_continuous_aggregates.sql
echo "Done. You can verify with: psql \"$DSN\" -f timescale/tests/verify_continuous_agg.sql"
