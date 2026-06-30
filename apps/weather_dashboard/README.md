# Weather RTOS — Historical Dashboard

Interactive historical weather data explorer and dataset comparison tool.

## Prerequisites

- The `map_query_api` backend must be running on port 8091 (or whichever port you configure).
- Optionally, TimescaleDB should be populated with weather data for live queries.

## Run

Start the API (from the build directory):

```bash
cd /home/wolfe/Documents/weather-rtos/build
./map_query_api 8091
```

Serve the dashboard:

```bash
cd /home/wolfe/Documents/weather-rtos/apps/weather_dashboard
python3 -m http.server 5174
```

Open in your browser:

```
http://127.0.0.1:5174
```

## Features

### Historical Explorer
- Select a city, date range, and time interval
- Visualize temperature, humidity, and wind speed on multi-axis charts
- View aggregate statistics (min/max/avg) for the selected range

### Dataset Comparison
- Upload a CSV or JSON file with your own historical weather data
- The dashboard auto-detects column mappings (timestamp, temperature, humidity, wind_speed)
- Choose a city to compare against — the system fetches data for the same time range
- Side-by-side overlay chart with color-coded variance visualization

### CSV Format

Your CSV file should have a header row. Example:

```csv
timestamp,temperature,humidity,wind_speed
2025-06-01T00:00:00Z,28.5,62.0,12.3
2025-06-01T01:00:00Z,27.8,65.0,11.1
```

### JSON Format

```json
[
  { "timestamp": "2025-06-01T00:00:00Z", "temperature": 28.5, "humidity": 62.0, "wind_speed": 12.3 },
  { "timestamp": "2025-06-01T01:00:00Z", "temperature": 27.8, "humidity": 65.0, "wind_speed": 11.1 }
]
```
