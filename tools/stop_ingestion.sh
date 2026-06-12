#!/usr/bin/env bash
set -euo pipefail
pkill -f 'build/timescale_writer' 2>/dev/null || true
pkill -f 'build/hierarchical_aggregator' 2>/dev/null || true
pkill -f 'build/regional_collector' 2>/dev/null || true
echo "Ingestion pipeline stopped."
