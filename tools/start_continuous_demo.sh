#!/bin/bash
# Weather RTOS: Continuous Streaming Demo (Real API Data)
# Uses simulator/main.cpp to fetch live Open-Meteo data and send it to the pipeline continuously

set -e

# --- Colors ---
COLOR_GREEN='\033[0;32m'
COLOR_BLUE='\033[0;34m'
COLOR_YELLOW='\033[1;33m'
COLOR_RESET='\033[0m'

# --- Project Root ---
PROJECT_ROOT=$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)
cd "$PROJECT_ROOT"

# --- Step 1: Cleanup ---
echo -e "${COLOR_BLUE}=== Weather RTOS: Continuous Streaming Demo ===${COLOR_RESET}"
echo -e "${COLOR_YELLOW}Step 1/5: Cleaning up old state...${COLOR_RESET}"
pkill -f "timescale_writer" || true
pkill -f "simulator" || true
sudo docker compose -f ops/docker/docker-compose.pipeline.yml down 2>/dev/null || true
echo -e "${COLOR_GREEN}✓ Cleanup complete${COLOR_RESET}\n"

# --- Step 2: Start Distributed Infrastructure ---
echo -e "${COLOR_YELLOW}Step 2/5: Starting observability & storage stack...${COLOR_RESET}"
sudo docker compose -f ops/docker/docker-compose.pipeline.yml up -d
sleep 15
echo -e "${COLOR_GREEN}✓ Infrastructure ready${COLOR_RESET}\n"

# --- Step 3: Start Timescale Writer ---
echo -e "${COLOR_YELLOW}Step 3/5: Starting Timescale Weather Writer...${COLOR_RESET}"
rm -f timescale_writer_demo.log
./build/timescale_writer > timescale_writer_demo.log 2>&1 &
WRITER_PID=$!
sleep 5
echo -e "${COLOR_GREEN}✓ Writer started (PID $WRITER_PID)${COLOR_RESET}\n"

# --- Step 4: Start Real Weather Simulator (Continuous API Fetch) ---
echo -e "${COLOR_YELLOW}Step 4/5: Starting Real Weather Simulator (Open-Meteo API)...${COLOR_RESET}"
rm -f simulator_demo.log
./build/simulator > simulator_demo.log 2>&1 &
SIMULATOR_PID=$!
sleep 3
echo -e "${COLOR_GREEN}✓ Simulator started (PID $SIMULATOR_PID) - fetching real weather from Chennai!${COLOR_RESET}\n"

# --- Step 5: Verify Health ---
echo -e "${COLOR_YELLOW}Step 5/5: Verifying system health...${COLOR_RESET}"
if curl -s http://127.0.0.1:9100/metrics > /dev/null; then
    echo -e "${COLOR_GREEN}✓ Metrics endpoint healthy${COLOR_RESET}"
else
    echo -e "❌ Metrics endpoint failed to respond"
    exit 1
fi
echo -e "${COLOR_GREEN}✓ System health verified${COLOR_RESET}\n"

# --- Final Instructions ---
echo -e "\n${COLOR_BLUE}=== Continuous Streaming Demo Started! ===${COLOR_RESET}"
echo -e "\n✅ What's happening now:"
echo -e "   • Simulator is fetching real weather data from Open-Meteo API (Chennai, India)"
echo -e "   • Data is being sent to the pipeline continuously every 5 seconds"
echo -e "   • Data is being stored in TimescaleDB with real-time metrics"
echo -e "\n✅ What to show your mentor:"
echo -e "   1. SSH Tunnel: Run this on YOUR local machine first:"
echo -e "      ssh -L 3001:localhost:3001 -L 9095:localhost:9095 wolfe@100.66.153.50"
echo -e "   2. Grafana: Open http://localhost:3001"
echo -e "      Go to Dashboards > WeatherRTOS > Weather RTOS - Writer Metrics"
echo -e "   3. Prometheus Targets: Open http://localhost:9095/targets"
echo -e "   4. Watch logs (Optional): tail -f timescale_writer_demo.log"
echo -e "\n✅ To STOP this demo later:"
echo -e "   ./tools/stop_continuous_demo.sh"
