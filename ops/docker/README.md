Docker demo for Weather RTOS

This directory contains a `docker-compose.yml` and a `Dockerfile` to run a small demo stack locally:

- `timescaledb` (TimescaleDB/Postgres)
- `prometheus` (Prometheus server scraping the writer metrics)
- `grafana` (Grafana, import the provided dashboard)
- `timescale_writer` (built from this repository)
- `simulator` (built from this repository; runs synthetic traffic)

Quick run (requires Docker and Docker Compose):

```bash
# from repo root
cd ops/docker
docker compose up --build
```

Grafana: http://localhost:3000 (admin/admin)
Prometheus: http://localhost:9090
Writer metrics: http://localhost:9100/metrics

No Docker? Run the components natively instead (see repo `docs/QUICKSTART.md`).
