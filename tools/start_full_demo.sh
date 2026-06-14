#!/bin/bash
# Weather RTOS: Full Pipeline Demo Orchestrator
# Cleans up old state, starts all services, and runs the load test

set -e  # Exit on error
set -o pipefail  # Exit if any command in a pipeline fails

# --- Colors for Pretty Output ---
COLOR_GREEN='\033[0;32m'
COLOR_BLUE='\033[0;34m'
COLOR_YELLOW='\033[1;33m'
COLOR_RESET='\033[0m'

# --- Project Root ---
PROJECT_ROOT=$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)
cd "$PROJECT_ROOT"

# --- Step 1: Cleanup ---
echo -e "${COLOR_BLUE}=== Weather RTOS Full Demo ===${COLOR_RESET}"
echo -e "${COLOR_YELLOW}Step 1/6: Cleaning up old state...${COLOR_RESET}"
pkill -f "timescale_writer" || true
sudo docker compose -f ops/docker/docker-compose.pipeline.yml down 2>/dev/null || true
echo -e "${COLOR_GREEN}✓ Cleanup complete${COLOR_RESET}\n"

# --- Step 2: Start Distributed Infrastructure ---
echo -e "${COLOR_YELLOW}Step 2/6: Starting distributed infrastructure...${COLOR_RESET}"
sudo docker compose -f ops/docker/docker-compose.pipeline.yml up -d
sleep 15  # Give more time for Grafana to provision
echo -e "${COLOR_GREEN}✓ Infrastructure ready${COLOR_RESET}\n"

# --- Step 3: Start Weather Writer ---
echo -e "${COLOR_YELLOW}Step 3/6: Starting Timescale Weather Writer...${COLOR_RESET}"
rm -f timescale_writer_demo.log
./build/timescale_writer > timescale_writer_demo.log 2>&1 &
WRITER_PID=$!
sleep 5
echo -e "${COLOR_GREEN}✓ Writer started (PID $WRITER_PID)${COLOR_RESET}\n"

# --- Step 4: Verify Health ---
echo -e "${COLOR_YELLOW}Step 4/6: Verifying system health...${COLOR_RESET}"
if curl -s http://127.0.0.1:9100/metrics > /dev/null; then
    echo -e "${COLOR_GREEN}✓ Metrics endpoint healthy${COLOR_RESET}"
else
    echo -e "❌ Metrics endpoint failed to respond"
    exit 1
fi
echo -e "${COLOR_GREEN}✓ System health verified${COLOR_RESET}\n"

# --- Step 5: Run Load Test ---
echo -e "${COLOR_YELLOW}Step 5/6: Executing load test (100,000 messages)...${COLOR_RESET}"
python3 tools/load_test_ingestion.py
echo -e "${COLOR_GREEN}✓ Load test complete${COLOR_RESET}\n"

# --- Step 6: Quick Data Check ---
echo -e "${COLOR_YELLOW}Step 6/6: Quick data validation check...${COLOR_RESET}"
echo "Fetching 10 most recent observations from TimescaleDB..."
PGPASSWORD=weather_secret psql -h 127.0.0.1 -U weather_rtos -d weather_rtos -c "SELECT event_time, city, temperature, humidity, wind_speed FROM weather_observations_raw ORDER BY event_time DESC LIMIT 5;"

# --- Final Instructions ---
echo -e "\n${COLOR_BLUE}=== Demo Complete! ===${COLOR_RESET}"
echo -e "\n✅ What to show your mentor now:"
echo -e "   1. Access Grafana: http://localhost:3001 (user: admin, pass: admin)"
echo -e "      - Go to Dashboards -> WeatherRTOS -> Weather RTOS - Writer Metrics"
echo -e "   2. Access Prometheus: http://localhost:9095/targets (should see 2 green 'UP' targets)"
echo -e "   3. Monitor logs: tail -f timescale_writer_demo.log"
echo -e "\n❗ Important: Local tunnel command to run on your computer FIRST:"
echo -e "   ssh -L 3001:localhost:3001 -L 9095:localhost:9095 wolfe@100.66.153.50"
echo -e "\nTo stop the demo later, run: ./tools/stop_full_demo.sh"
