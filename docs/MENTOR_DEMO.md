# Weather RTOS: Data Ingestion Pipeline Demo Guide
## 🎯 Two Demo Options
1.  **Load Test Demo**: Scalability (100k fixed messages)
2.  **Continuous Streaming Demo**: Real-world use case (live API data streaming continuously)

---

## 🚀 Quick Start (Mentor Demo)
### Option 1: Load Test Demo (Scalability)
#### Step 1: Run the One‑Click Load Test
From your SSH session on the remote machine:
```bash
cd ~/Documents/weather-rtos
./tools/start_full_demo.sh
```
#### Step 2: Establish Local Tunnel
From your **local Windows/Mac/Linux** machine (not SSH):
```bash
ssh -L 3001:localhost:3001 -L 9095:localhost:9095 wolfe@100.66.153.50
```
#### Step 3: Open Interfaces & Present
1.  **Grafana (Observability)**: [http://localhost:3001](http://localhost:3001)
    - User: `admin`
    - Pass: `admin`
    - Go to **Dashboards** → **WeatherRTOS** → **Weather RTOS - Writer Metrics**
2.  **Prometheus (Targets Check)**: [http://localhost:9095/targets](http://localhost:9095/targets)
3.  **Live Logs**: `tail -f ~/Documents/weather-rtos/timescale_writer_demo.log`

### Option 2: Continuous Streaming Demo (Real‑World API Data)
#### Step 1: Run Continuous Streaming Demo
From your SSH session on the remote machine:
```bash
cd ~/Documents/weather-rtos
./tools/start_continuous_demo.sh
```
This fetches **real weather data from Open-Meteo API** for Chennai, India and streams it continuously!
#### Step 2: Establish Local Tunnel
From your **local Windows/Mac/Linux** machine (not SSH):
```bash
ssh -L 3001:localhost:3001 -L 9095:localhost:9095 wolfe@100.66.153.50
```
#### Step 3: Open Interfaces & Present
1.  **Grafana (Observability)**: [http://localhost:3001](http://localhost:3001)
    - User: `admin`
    - Pass: `admin`
    - Go to **Dashboards** → **WeatherRTOS** → **Weather RTOS - Writer Metrics**
2.  **Prometheus (Targets Check)**: [http://localhost:9095/targets](http://localhost:9095/targets)
3.  **Live Logs**:
    ```bash
    tail -f ~/Documents/weather-rtos/simulator_demo.log  # Real API calls
    tail -f ~/Documents/weather-rtos/timescale_writer_demo.log  # Data being written
    ```
4.  **Verify Real Data in DB**:
    ```bash
    PGPASSWORD=weather_secret psql -h 127.0.0.1 -U weather_rtos -d weather_rtos -c "SELECT event_time, city, temperature, humidity, wind_speed FROM weather_observations_raw ORDER BY event_time DESC LIMIT 5;"
    ```

---

## 📋 Presentation Outline (Mentor‑Facing)
### 1. Architecture Overview
*"We built a **4‑tier distributed data pipeline**"*
1.  **Data Source Layer**: `simulator` (Open‑Meteo API) + `regional_collector` (multi‑city topology)
2.  **Aggregation Layer**: `hierarchical_aggregator` (regional/continent/global)
3.  **Storage Layer**: TimescaleDB (time‑series) + ClickHouse (analytics)
4.  **Observability Layer**: Prometheus/Grafana (auto‑provisioned)

### 2. Two Demo Options
- **Load Test**: Show scalability (100k messages, throughput spikes)
- **Continuous Streaming**: Show real‑world logistics use case (live Chennai weather data)

### 3. RT‑Safe & Production‑Grade Features
*"This is production‑ready for logistics/RTOS use cases"*
- **RT‑Safe IPC**: `common/rt_safe/LocklessRingBuffer.hpp` (mutex‑free, deterministic)
- **Memory Safety**: Bounded duplicate FIFO cache (prevents OOM)
- **Data Durability**: Timescale outbox fallback (prevents data loss)
- **Backpressure**: Bounded queues (prevents cascading failure)
- **Observability**: Full Prometheus/Grafana stack for 99.9% visibility

### 4. Sustainability & Production Deployment
*"This is sustainable for long‑term production use"*
- CMake build system (reproducible builds)
- Systemd service files (process supervision, auto‑restart)
- Log rotation configuration
- Config files in `configs/` (environment‑based, not hardcoded)
- See full guide: [ARCHITECTURE_SUSTAINABILITY.md](docs/ARCHITECTURE_SUSTAINABILITY.md)

---

## 📂 Key Files to Show Your Mentor
| File | Purpose |
|------|---------|
| [common/timescale/TimescaleBatchWriter.hpp](common/timescale/TimescaleBatchWriter.hpp) | Core batching/storage engine |
| [common/rt_safe/LocklessRingBuffer.hpp](common/rt_safe/LocklessRingBuffer.hpp) | RT‑safe IPC queue |
| [simulator/main.cpp](simulator/main.cpp) | Real weather API fetcher (continuous streaming) |
| [tools/start_continuous_demo.sh](tools/start_continuous_demo.sh) | One‑click continuous streaming demo |
| [ops/grafana/weather_rtos_dashboard.json](ops/grafana/weather_rtos_dashboard.json) | Auto‑provisioned Grafana dashboard |
| [docs/ARCHITECTURE_SUSTAINABILITY.md](docs/ARCHITECTURE_SUSTAINABILITY.md) | Full production architecture guide |

---

## 🛑 Cleanup After Demo
### Load Test Cleanup
```bash
./tools/stop_full_demo.sh
```
### Continuous Streaming Cleanup
```bash
./tools/stop_continuous_demo.sh
```
