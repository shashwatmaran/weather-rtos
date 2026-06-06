# Weather RTOS Map Console

A minimal browser UI for the Phase 1 map-first logistics flow.

## What it does
- Fetches tile overlays from `GET /v1/map/tiles`
- Fetches route risk from `POST /v1/routes/risk`
- Renders a simple risk map with a route panel

## Run it

Start the API first:

```bash
cd /home/wolfe/Documents/weather-rtos/build
./map_query_api 8091
```

Serve the UI from this folder:

```bash
cd /home/wolfe/Documents/weather-rtos/apps/map_console
python3 -m http.server 5173
```

Then open:

```text
http://127.0.0.1:5173
```

## Notes
- The API now enables CORS for browser clients.
- The UI uses OpenStreetMap tiles and Leaflet from CDNs.
- Update the API base URL in the sidebar if your port differs.
