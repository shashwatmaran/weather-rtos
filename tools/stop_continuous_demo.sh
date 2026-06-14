#!/bin/bash
# Weather RTOS: Stop Continuous Streaming Demo
# Gracefully stops all services

set -e

PROJECT_ROOT=$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)
cd "$PROJECT_ROOT"

echo "=== Weather RTOS: Stopping Continuous Streaming Demo ==="

# Stop native services
echo "Stopping timescale_writer..."
pkill -f "timescale_writer" || true

echo "Stopping simulator..."
pkill -f "simulator" || true

# Stop Docker services
echo "Stopping Docker containers..."
sudo docker compose -f ops/docker/docker-compose.pipeline.yml down

echo "✅ Continuous streaming demo stopped!"
