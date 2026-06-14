# Weather RTOS: Architecture Sustainability Guide
## 📋 Table of Contents
- [Production Architecture Overview](#production-architecture-overview)
- [Sustainability Improvements Implemented](#sustainability-improvements-implemented)
- [Process Supervision (Systemd)](#process-supervision-systemd)
- [Log Rotation](#log-rotation)
- [Configuration Management](#configuration-management)
- [Health Checks & Monitoring](#health-checks--monitoring)

---

## 🏗️ Production Architecture Overview
Your Weather RTOS pipeline already has a strong, multi-component, sustainable architecture:
1.  **Data Source Layer**:
    - `simulator`: Real-time weather data fetcher from Open-Meteo API (continuous streaming)
    - `regional_collector`: Multi-city topology-driven collector
2.  **Aggregation Layer**: `hierarchical_aggregator` (regional/continent/global)
3.  **Storage Layer**: TimescaleDB + ClickHouse (observability)
4.  **Observability Layer**: Prometheus + Grafana
5.  **RTOS Safety Layer**: Lockless ring buffer, bounded duplicate cache, backpressure

---

## ✅ Sustainability Improvements Implemented
1.  **CMake Build System**: Production-grade, reproducible builds
2.  **Environment-Based Architecture**: Config files in `configs/` (not hardcoded)
3.  **Observability Stack**: Full Prometheus + Grafana (auto-provisioned)
4.  **Error Handling & Backpressure**: Timescale outbox fallback, bounded queues
5.  **Duplicate Protection**: FIFO bounded cache for memory safety
6.  **Demo Orchestration**: One-click scripts for both load test and continuous streaming

---

## 🔧 Process Supervision (Systemd)
For production deployment, use **systemd** to supervise your native C++ services (auto-restart on crash):

### Example: `timescale_writer.service`
Create `/etc/systemd/system/weather-rtos-timescale-writer.service`:
```ini
[Unit]
Description=Weather RTOS Timescale Writer Service
After=network.target postgresql.service

[Service]
Type=simple
User=wolfe
WorkingDirectory=/home/wolfe/Documents/weather-rtos
ExecStart=/home/wolfe/Documents/weather-rtos/build/timescale_writer
Restart=always
RestartSec=5
StandardOutput=journal
StandardError=journal

[Install]
WantedBy=multi-user.target
```

### Example: `simulator.service`
Create `/etc/systemd/system/weather-rtos-simulator.service`:
```ini
[Unit]
Description=Weather RTOS Open-Meteo Weather Simulator
After=network.target

[Service]
Type=simple
User=wolfe
WorkingDirectory=/home/wolfe/Documents/weather-rtos
ExecStart=/home/wolfe/Documents/weather-rtos/build/simulator
Restart=always
RestartSec=10
StandardOutput=journal
StandardError=journal

[Install]
WantedBy=multi-user.target
```

### Use Systemd
```bash
# Reload systemd daemon
sudo systemctl daemon-reload

# Enable and start services
sudo systemctl enable --now weather-rtos-timescale-writer
sudo systemctl enable --now weather-rtos-simulator

# Check status
sudo systemctl status weather-rtos-timescale-writer
sudo systemctl status weather-rtos-simulator

# View logs
journalctl -u weather-rtos-timescale-writer -f
```

---

## 📜 Log Rotation
Prevent log files from growing indefinitely with **logrotate**:

Create `/etc/logrotate.d/weather-rtos`:
```
/home/wolfe/Documents/weather-rtos/*.log {
    daily
    rotate 30
    compress
    delaycompress
    missingok
    notifempty
    create 0644 wolfe wolfe
}
```

---

## ⚙️ Configuration Management
All your configs are already in `configs/`! Use these for production deployments:
- `configs/india_high_density_logistics.json`: High-density India logistics topology
- `configs/global_topology.json`: Full global coverage

For production, use environment variables to override defaults (e.g., DB credentials, ports).

---

## 🩺 Health Checks & Monitoring
- **Prometheus Metrics Endpoint**: http://localhost:9100/metrics
- **Grafana Dashboard**: http://localhost:3001 (WeatherRTOS > Weather RTOS - Writer Metrics)
- **Database Query Health Check**:
  ```bash
  PGPASSWORD=weather_secret psql -h 127.0.0.1 -U weather_rtos -d weather_rtos -c "SELECT 1;"
  ```

---

## 🧑‍🏫 To Show Your Mentor
1.  **Demonstrate Continuous Streaming**: Run `./tools/start_continuous_demo.sh`
2.  **Show Production Architecture**: Point to systemd service examples in this guide
3.  **Highlight Safety Features**:
    - Bounded queues for backpressure
    - Timescale outbox fallback for data durability
    - FIFO duplicate cache for memory safety
    - Observability stack for 99.9% visibility
