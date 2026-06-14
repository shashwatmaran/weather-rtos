#!/bin/bash
# Weather RTOS: Stop Demo & Cleanup
# Gracefully stops all services and cleans up

set -e

PROJECT_ROOT=$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)
cd "$PROJECT_ROOT"

echo "=== Weather RTOS Demo Cleanup ==="

# Stop the writer
echo "Stopping timescale_writer..."
pkill -f "timescale_writer" || true

# Stop Docker services
echo "Stopping Docker containers..."
sudo docker compose -f ops/docker/docker-compose.pipeline.yml down

echo "✓ Demo stopped and cleaned up successfully!"
