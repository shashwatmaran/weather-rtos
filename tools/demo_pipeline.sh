#!/bin/bash
# demo_pipeline.sh - Comprehensive demonstration for mentor

set -e

# Colors for better readability
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NC='\033[0m'

echo -e "${BLUE}=== Weather RTOS Ingestion Pipeline Demo ===${NC}"

# 1. Cleanup and Build
echo -e "\n${GREEN}[Step 1] Building system components...${NC}"
mkdir -p build && cd build && cmake .. > /dev/null && make -j4 > /dev/null
cd ..

# 2. Demonstrate RTOS Benchmarks (Jitter & Throughput)
echo -e "\n${GREEN}[Step 2] Demonstrating RTOS-Safe IPC & Latency...${NC}"
./build/rt_bench

# 3. Demonstrate Ingestion Pipeline Flow
echo -e "\n${GREEN}[Step 3] Starting Ingestion Pipeline...${NC}"
# Use the existing start script but wrap it for the demo
export ENABLE_PIPELINE_LOGGING=1
./tools/start_ingestion.sh

echo -e "\n${BLUE}Pipeline is running.${NC}"
echo "Check /mnt/huge for hugepages usage (if configured)"
echo "Check Prometheus metrics at http://localhost:9100/metrics"
echo "Check logs in ./logs/"

# 4. Show real-time processing
echo -e "\n${GREEN}[Step 4] Monitoring live data consumption...${NC}"
timeout 10 tail -f logs/timescale_writer.log | grep "Consumed" || echo "Monitoring finished."

# 5. Show handling of duplicates (Efficiency feature)
echo -e "\n${GREEN}[Step 5] Demonstrating Duplicate Message Handling...${NC}"
# Send a duplicate message manually
printf '{"schema_version": 1, "message_id": "duplicate-test-1", "source": "demo", "route": "demo", "message_type": "weather.packet", "created_at": 1623234000000, "payload": {"continent": "Asia", "country": "India", "region": "south_india", "city": "Chennai", "temperature": 25.0, "humidity": 50.0, "wind_speed": 5.0, "timestamp": 1623234000000}}\n' | nc -q 1 localhost 13101
sleep 1
printf '{"schema_version": 1, "message_id": "duplicate-test-1", "source": "demo", "route": "demo", "message_type": "weather.packet", "created_at": 1623234000000, "payload": {"continent": "Asia", "country": "India", "region": "south_india", "city": "Chennai", "temperature": 25.0, "humidity": 50.0, "wind_speed": 5.0, "timestamp": 1623234000000}}\n' | nc -q 1 localhost 13101

echo "Checking writer logs for duplicate detection..."
grep "Duplicate envelope ignored" logs/timescale_writer.log | tail -n 1

# 6. Cleanup
echo -e "\n${GREEN}[Step 6] Stopping pipeline...${NC}"
./tools/stop_ingestion.sh
echo -e "\n${BLUE}Demo Complete.${NC}"
