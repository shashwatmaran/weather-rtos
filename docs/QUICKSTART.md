# Quickstart

This quickstart shows the minimal steps to build and run the demo locally.

Prerequisites
- CMake (>=3.10), a C++17-capable compiler (g++/clang++) and `make` or `ninja`.
- Optional: TimescaleDB (Postgres) if you want persistence for the `timescale_writer`.

Build
```bash
git clone <repo> weather-rtos
cd weather-rtos
mkdir -p build && cd build
cmake ..
cmake --build . -j 4
```

Run demo (defaults)
```bash
cd /path/to/weather-rtos
./demo.sh
```

Environment variables
- `TIMESCALEDB_DSN` — database DSN for TimescaleDB writer. Default is set in `demo.sh`.
- `WEATHER_RTOS_HOST` — network host used by components.
- `LOGDIR` — override default log location; default is `logs/` in repository root.

Inspect logs
- By default component stdout/stderr and consumer logs are written to `logs/`.
- Rotate logs manually:
```bash
logs/rotate.sh
```

Run a component individually
- You can run a single component from `build/`, e.g.:
```bash
./build/hierarchical_aggregator asia_continent
```
- The full demo uses the hierarchical chain already wired in [demo.sh](demo.sh), so you do not need to assemble separate region-by-region trees to confirm the architecture.

Notes
- If you don't have TimescaleDB, the `timescale_writer` will run but writes will fail; set `TIMESCALEDB_DSN` to a reachable DB to enable persistence.
- For the Phase 1 DB path, apply `timescale/schema.sql`, `timescale/map_phase1.sql`, and `timescale/migrations/005_storage_policies.sql` in that order.
- Then apply `timescale/migrations/006_ingestion_layers.sql` so raw rows keep explicit source-layer and waypoint metadata.
- For development prefer running a single component and exercising its inputs via the simulator or curl/sockets.
- Collectors now sample each city center plus a small waypoint ring around it, so the demo shows intra-city spatial variation instead of one point per city.


Use this as your demo runbook:

1. Start the API server with the database DSN.
```bash
cd /home/wolfe/Documents/weather-rtos
TIMESCALEDB_DSN='host=127.0.0.1 port=5432 dbname=weather_rtos user=weather_rtos password=weather_secret' ./build/map_query_api 8091
```

2. Start the map console in a second terminal.
```bash
cd /home/wolfe/Documents/weather-rtos/apps/map_console
python3 -m http.server 8000
```

3. Open the UI in your browser.
```text
http://127.0.0.1:8000/index.html
```

4. In the UI, show these in order:
   - the live raster heat layer on the map
   - switching the layer dropdown between Hazard, Wind, Pressure, Visibility, Cloud, Precipitation
   - moving the time slider and hitting refresh
   - the summary panel updating
   - the route risk button showing segment risk

5. Optional but useful before the demo:
```bash
python3 /home/wolfe/Documents/weather-rtos/tools/warm_tiles.py \
  --api http://127.0.0.1:8091 \
  --min-lon 72 --min-lat 12 --max-lon 79 --max-lat 18 \
  --min-z 5 --max-z 7 --layer hazard --delay 0.01
```

6. If the map looks empty, do not panic:
   - the tiles may still be loading
   - click Refresh tiles once
   - check that the API terminal is still running
   - make sure the API base URL in the UI is `http://127.0.0.1:8091`

Systemd runbook
- The repo includes service templates in [services/systemd/](services/systemd).
- To install them on a Linux host:
```bash
sudo cp services/systemd/*.service /etc/systemd/system/
sudo systemctl daemon-reload
sudo systemctl enable --now regional_collector.service
sudo systemctl enable --now timescale_writer.service
sudo systemctl enable --now map_query_api.service
```

If you want, I can also give you a 30-second spoken demo script so you can narrate it cleanly.


ss -ltnp '( sport = :8091 )'

kill <pid>