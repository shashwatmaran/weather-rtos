const apiBaseInput = document.getElementById('apiBase');
const layerSelect = document.getElementById('layerSelect');
const bboxInput = document.getElementById('bboxInput');
const timeSlider = document.getElementById('timeSlider');
const timeLabel = document.getElementById('timeLabel');
const resetTimeButton = document.getElementById('resetTime');
const routeIdInput = document.getElementById('routeIdInput');
const segmentIdsInput = document.getElementById('segmentIdsInput');
const refreshTilesButton = document.getElementById('refreshTiles');
const refreshRouteButton = document.getElementById('refreshRoute');
const tileCountElement = document.getElementById('tileCount');
const routeHazardElement = document.getElementById('routeHazard');
const etaDeltaElement = document.getElementById('etaDelta');
const segmentListElement = document.getElementById('segmentList');
const summaryHazardElement = document.getElementById('summaryHazard');
const summaryLayerElement = document.getElementById('summaryLayer');
const summaryTempElement = document.getElementById('summaryTemp');
const summaryHumidityElement = document.getElementById('summaryHumidity');
const summaryWindElement = document.getElementById('summaryWind');
const summaryPressureElement = document.getElementById('summaryPressure');
const summaryCloudElement = document.getElementById('summaryCloud');
const summaryVisibilityElement = document.getElementById('summaryVisibility');
const summaryPrecipitationElement = document.getElementById('summaryPrecipitation');
const summarySourceElement = document.getElementById('summarySource');

function defaultApiBase() {
  const { hostname, protocol } = window.location;

  if (!hostname || hostname === 'localhost' || hostname === '127.0.0.1') {
    return 'http://127.0.0.1:8091';
  }

  return `${protocol}//${hostname}:8091`;
}

if (!apiBaseInput.value || apiBaseInput.value === 'http://127.0.0.1:8091') {
  apiBaseInput.value = defaultApiBase();
}

const map = L.map('map', { zoomControl: true }).setView([15.0, 76.5], 5);
L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
  attribution: '&copy; OpenStreetMap contributors',
  maxZoom: 19,
}).addTo(map);

const heatLayer = L.heatLayer([], {
  radius: 44,
  blur: 30,
  minOpacity: 0.24,
  maxZoom: 12,
  gradient: {
    0.1: '#1e3a8a',
    0.25: '#2563eb',
    0.45: '#06b6d4',
    0.65: '#22c55e',
    0.82: '#f59e0b',
    1.0: '#ef4444',
  },
}).addTo(map);

let rasterLayer = null;

const CITY_COORDINATES = {
  'south_india:Bangalore': [12.9716, 77.5946],
  'south_india:Hyderabad': [17.385, 78.4867],
  'south_india:Chennai': [13.0827, 80.2707],
  'south_india:Kochi': [9.9312, 76.2673],
  'south_india:Madurai': [9.9252, 78.1198],
  'south_india:Mysore': [12.2958, 76.6394],
  'north_india:Delhi': [28.7041, 77.1025],
  'north_india:Mumbai': [19.076, 72.8777],
  'north_india:Jaipur': [26.9124, 75.7873],
  'north_india:Lucknow': [26.8467, 80.9462],
  'north_india:Ahmedabad': [23.0225, 72.5714],
  'north_india:Chandigarh': [30.7333, 76.7794],
  'europe:Paris': [48.8566, 2.3522],
  'europe:London': [51.5074, -0.1278],
  'americas:New York': [40.7128, -74.006],
  'americas:Los Angeles': [34.0522, -118.2437],
};

let activeRouteLine = null;
let activeRouteMarkers = [];
let selectedTime = new Date();
let timeSliceEnabled = false;

function apiBase() {
  return apiBaseInput.value.replace(/\/$/, '');
}

function rasterTileUrl(layer) {
  const layerName = encodeURIComponent(layer);
  const timeParam = currentTimeParam();
  const suffix = timeParam ? `&at=${encodeURIComponent(timeParam)}` : '';
  return `${apiBase()}/v1/map/tiles/png/{z}/{x}/{y}?layer=${layerName}${suffix}`;
}

function syncRasterLayer() {
  const url = rasterTileUrl(layerSelect.value);
  if (rasterLayer) {
    rasterLayer.remove();
  }

  rasterLayer = L.tileLayer(url, {
    tileSize: 256,
    opacity: 0.82,
    maxZoom: 12,
    minZoom: 2,
    crossOrigin: true,
    errorTileUrl: 'data:image/gif;base64,R0lGODlhAQABAIAAAAAAAP///ywAAAAAAQABAAACAUwAOw==',
  }).addTo(map);
}

function riskColor(value) {
  if (value >= 80) return '#ef4444';
  if (value >= 60) return '#fb7185';
  if (value >= 35) return '#f59e0b';
  return '#34d399';
}

function hazardLabel(value) {
  if (value >= 80) return 'Extreme';
  if (value >= 60) return 'High';
  if (value >= 35) return 'Medium';
  return 'Low';
}

function formatTimeSlice(date) {
  return new Intl.DateTimeFormat(undefined, {
    month: 'short',
    day: 'numeric',
    hour: '2-digit',
    minute: '2-digit',
  }).format(date);
}

function updateTimeLabel() {
  timeLabel.textContent = formatTimeSlice(selectedTime);
}

function currentTimeParam() {
  return timeSliceEnabled ? selectedTime.toISOString() : '';
}

function currentBBox() {
  const [minLon, minLat, maxLon, maxLat] = parseBBox(bboxInput.value);
  return { minLon, minLat, maxLon, maxLat };
}

function parseBBox(raw) {
  const parts = raw.split(',').map((item) => Number(item.trim()));
  if (parts.length !== 4 || parts.some((item) => Number.isNaN(item))) {
    throw new Error('bbox must be minLon,minLat,maxLon,maxLat');
  }
  return parts;
}

function formatMetricValue(value, digits = 1, suffix = '') {
  if (value === null || value === undefined || Number.isNaN(Number(value))) {
    return 'n/a';
  }
  return `${Number(value).toFixed(digits)}${suffix}`;
}

function heatIntensity(layer, value) {
  const numeric = Number(value ?? 0);

  if (layer === 'visibility') {
    return Math.max(0.08, Math.min(1, 1 - Math.min(numeric, 20) / 20));
  }

  if (layer === 'precipitation') {
    return Math.max(0.08, Math.min(1, numeric / 50));
  }

  if (layer === 'wind') {
    return Math.max(0.08, Math.min(1, numeric / 100));
  }

  if (layer === 'cloud') {
    return Math.max(0.08, Math.min(1, numeric / 100));
  }

  if (layer === 'pressure') {
    return Math.max(0.08, Math.min(1, Math.abs(numeric - 1013) / 50));
  }

  return Math.max(0.08, Math.min(1, numeric / 100));
}

function resolveTileCoordinates(tile) {
  const latitude = Number(tile.latitude);
  const longitude = Number(tile.longitude);
  if (Number.isFinite(latitude) && Number.isFinite(longitude)) {
    return { latitude, longitude };
  }

  const tileId = String(tile.tile_id ?? '');
  if (tileId.includes(':') && CITY_COORDINATES[tileId]) {
    const [resolvedLatitude, resolvedLongitude] = CITY_COORDINATES[tileId];
    return { latitude: resolvedLatitude, longitude: resolvedLongitude };
  }

  const region = String(tile.region ?? '');
  const cityName = tileId.includes(':') ? tileId.split(':').slice(1).join(':') : tileId;
  const fallbackKey = `${region}:${cityName}`;
  if (CITY_COORDINATES[fallbackKey]) {
    const [resolvedLatitude, resolvedLongitude] = CITY_COORDINATES[fallbackKey];
    return { latitude: resolvedLatitude, longitude: resolvedLongitude };
  }

  return null;
}

function summarizeTiles(tiles, layer) {
  const validTiles = tiles
    .map((tile) => ({
      coordinates: resolveTileCoordinates(tile),
      layerValue: Number(tile.layer_value ?? 0),
      hazardScore: Number(tile.hazard_score ?? 0),
      temperature: tile.avg_temperature,
      humidity: tile.avg_humidity,
      wind: tile.avg_wind_speed,
      pressure: tile.avg_pressure_hpa,
      cloud: tile.avg_cloud_cover,
      visibility: tile.min_visibility_km,
      precipitation: tile.max_precipitation_mm,
    }))
    .filter((tile) => tile.coordinates);

  if (!validTiles.length) {
    return {
      layer,
      tile_count: 0,
      avg_temperature: null,
      avg_humidity: null,
      avg_wind_speed: null,
      avg_pressure_hpa: null,
      avg_cloud_cover: null,
      min_visibility_km: null,
      max_precipitation_mm: null,
      avg_hazard_score: null,
      layer_value: null,
      source: 'client_tiles',
    };
  }

  const count = validTiles.length;
  const sum = (selector) => validTiles.reduce((accumulator, tile) => accumulator + Number(selector(tile) ?? 0), 0);
  const average = (selector) => {
    const values = validTiles.map((tile) => Number(selector(tile))).filter((value) => Number.isFinite(value));
    return values.length ? values.reduce((accumulator, value) => accumulator + value, 0) / values.length : null;
  };
  const min = (selector) => {
    const values = validTiles.map((tile) => Number(selector(tile))).filter((value) => Number.isFinite(value));
    return values.length ? Math.min(...values) : null;
  };
  const max = (selector) => {
    const values = validTiles.map((tile) => Number(selector(tile))).filter((value) => Number.isFinite(value));
    return values.length ? Math.max(...values) : null;
  };

  return {
    layer,
    tile_count: count,
    avg_temperature: average((tile) => tile.temperature),
    avg_humidity: average((tile) => tile.humidity),
    avg_wind_speed: average((tile) => tile.wind),
    avg_pressure_hpa: average((tile) => tile.pressure),
    avg_cloud_cover: average((tile) => tile.cloud),
    min_visibility_km: min((tile) => tile.visibility),
    max_precipitation_mm: max((tile) => tile.precipitation),
    avg_hazard_score: average((tile) => tile.hazardScore),
    layer_value: average((tile) => tile.layerValue),
    source: 'client_tiles',
  };
}

function buildHeatField(tiles) {
  if (!tiles.length) return [];

  const points = tiles
    .map((tile) => {
      const coordinates = resolveTileCoordinates(tile);
      if (!coordinates) return null;
      return {
        lat: coordinates.latitude,
        lon: coordinates.longitude,
        intensity: heatIntensity(layerSelect.value, tile.layer_value),
      };
    })
    .filter((point) => point && Number.isFinite(point.lat) && Number.isFinite(point.lon));

  if (!points.length) return [];

  function haversine(aLat, aLon, bLat, bLon) {
    const R = 6371000;
    const toRad = Math.PI / 180.0;
    const dLat = (bLat - aLat) * toRad;
    const dLon = (bLon - aLon) * toRad;
    const sinDLat = Math.sin(dLat / 2);
    const sinDLon = Math.sin(dLon / 2);
    const aa = sinDLat * sinDLat + Math.cos(aLat * toRad) * Math.cos(bLat * toRad) * sinDLon * sinDLon;
    return R * (2 * Math.atan2(Math.sqrt(aa), Math.sqrt(1 - aa)));
  }

  const lats = points.map((point) => point.lat);
  const lons = points.map((point) => point.lon);
  const minLat = Math.min(...lats);
  const maxLat = Math.max(...lats);
  const minLon = Math.min(...lons);
  const maxLon = Math.max(...lons);

  const latSpan = Math.max(0.5, maxLat - minLat);
  const lonSpan = Math.max(0.5, maxLon - minLon);
  const rows = 40;
  const cols = 40;
  const latStep = latSpan / rows;
  const lonStep = lonSpan / cols;
  const grid = [];
  const power = 2.0;
  const eps = 1.0;

  for (let row = 0; row <= rows; row += 1) {
    for (let col = 0; col <= cols; col += 1) {
      const lat = minLat - latStep + row * latStep;
      const lon = minLon - lonStep + col * lonStep;

      let weightedSum = 0;
      let weightTotal = 0;

      for (const point of points) {
        const distance = haversine(lat, lon, point.lat, point.lon);
        const weight = 1.0 / Math.pow(distance + eps, power);
        weightedSum += point.intensity * weight;
        weightTotal += weight;
      }

      const intensity = weightTotal > 0 ? Math.max(0.02, Math.min(1, weightedSum / weightTotal)) : 0.02;
      grid.push([lat, lon, intensity]);
    }
  }

  return grid;
}

function clearRouteOverlay() {
  if (activeRouteLine) {
    activeRouteLine.remove();
    activeRouteLine = null;
  }
  activeRouteMarkers.forEach((marker) => marker.remove());
  activeRouteMarkers = [];
}

function renderTiles(tiles) {
  tileCountElement.textContent = String(tiles.length);
}

function renderRouteNotice(message) {
  clearRouteOverlay();
  segmentListElement.innerHTML = `<div class="segment-card"><div class="meta">${message}</div></div>`;
  routeHazardElement.textContent = '0.0';
  etaDeltaElement.textContent = '0.0 min';
}

function renderSummary(summary) {
  tileCountElement.textContent = String(summary.tile_count ?? 0);
  summaryHazardElement.textContent = formatMetricValue(summary.avg_hazard_score, 1);
  summaryLayerElement.textContent = formatMetricValue(summary.layer_value, 1);
  summaryTempElement.textContent = formatMetricValue(summary.avg_temperature, 1, '°C');
  summaryHumidityElement.textContent = formatMetricValue(summary.avg_humidity, 1, '%');
  summaryWindElement.textContent = formatMetricValue(summary.avg_wind_speed, 1, ' km/h');
  summaryPressureElement.textContent = formatMetricValue(summary.avg_pressure_hpa, 1, ' hPa');
  summaryCloudElement.textContent = formatMetricValue(summary.avg_cloud_cover, 0, '%');
  summaryVisibilityElement.textContent = formatMetricValue(summary.min_visibility_km, 1, ' km');
  summaryPrecipitationElement.textContent = formatMetricValue(summary.max_precipitation_mm, 1, ' mm');
  summarySourceElement.textContent = summary.source ?? 'n/a';
}

function renderRoute(route) {
  clearRouteOverlay();

  const segments = route.segments ?? [];
  const routePoints = Array.isArray(route.route_polyline)
    ? route.route_polyline
        .filter((point) => Array.isArray(point) && point.length >= 2)
        .map((point) => [Number(point[0]), Number(point[1])])
    : [];
  routeHazardElement.textContent = Number(route.route_hazard_score ?? 0).toFixed(1);
  etaDeltaElement.textContent = `${Number(route.projected_eta_delta_minutes ?? 0).toFixed(1)} min`;

  segmentListElement.innerHTML = '';

  if (routePoints.length === 0) {
    renderRouteNotice('No route geometry returned yet. Segment risk is shown in the side panel only until the API returns coordinates.');
  }

  segments.forEach((segment, index) => {
    const card = document.createElement('div');
    card.className = 'segment-card';
    card.innerHTML = `
      <strong>${segment.segment_id}</strong>
      <div class="meta">Region: ${segment.region}</div>
      <div class="meta">Hazard: ${Number(segment.hazard_score ?? 0).toFixed(1)} | Delay: ${Number(segment.delay_factor ?? 0).toFixed(2)}x | Driver: ${segment.primary_hazard ?? 'unknown'}</div>
    `;
    segmentListElement.appendChild(card);

  });

}

async function fetchJson(path, options = {}) {
  const response = await fetch(`${apiBase()}${path}`, {
    headers: {
      'Content-Type': 'application/json',
      ...(options.headers || {}),
    },
    ...options,
  });

  if (!response.ok) {
    const body = await response.text();
    throw new Error(`${response.status} ${response.statusText}: ${body}`);
  }

  return response.json();
}

async function fetchJsonWithRetry(path, options = {}, attempts = 2) {
  let lastError = null;
  for (let attempt = 1; attempt <= attempts; attempt += 1) {
    try {
      return await fetchJson(path, options);
    } catch (error) {
      lastError = error;
      if (attempt < attempts) {
        await new Promise((resolve) => setTimeout(resolve, 250 * attempt));
      }
    }
  }
  throw lastError;
}

async function loadSummary() {
  return null;
}

async function loadTiles() {
  const layer = layerSelect.value;
  const atQuery = currentTimeParam();
  const url = `${apiBase()}/v1/map/tiles?layer=${encodeURIComponent(layer)}${atQuery ? `&at=${encodeURIComponent(atQuery)}` : ''}`;
  const data = await fetchJsonWithRetry(url, {}, 2);
  const tiles = data.tiles ?? [];
  renderTiles(tiles);
  heatLayer.setLatLngs(buildHeatField(tiles));
  return tiles;
}

async function refreshMapData() {
  syncRasterLayer();
  try {
    const tiles = await loadTiles();
    renderSummary(summarizeTiles(tiles, layerSelect.value));
  } catch (error) {
    console.warn(error);
    renderSummary({
      layer: layerSelect.value,
      tile_count: 0,
      avg_temperature: null,
      avg_humidity: null,
      avg_wind_speed: null,
      avg_pressure_hpa: null,
      avg_cloud_cover: null,
      min_visibility_km: null,
      max_precipitation_mm: null,
      avg_hazard_score: null,
      layer_value: null,
      source: 'offline',
    });
    tileCountElement.textContent = '0';
  }
}

async function loadRouteRisk() {
  const routeId = routeIdInput.value.trim();
  const segmentIds = segmentIdsInput.value.split(',').map((item) => item.trim()).filter(Boolean);
  const atQuery = currentTimeParam();
  const data = await fetchJson('/v1/routes/risk', {
    method: 'POST',
    body: JSON.stringify({ route_id: routeId, segment_ids: segmentIds, ...(atQuery ? { at: atQuery } : {}) }),
  });
  renderRoute(data);
}

refreshTilesButton.addEventListener('click', async () => {
  refreshTilesButton.disabled = true;
  try {
    await refreshMapData();
  } catch (error) {
    console.warn(error);
  } finally {
    refreshTilesButton.disabled = false;
  }
});

refreshRouteButton.addEventListener('click', async () => {
  refreshRouteButton.disabled = true;
  try {
    await loadRouteRisk();
  } catch (error) {
    alert(`Route risk failed: ${error.message}`);
  } finally {
    refreshRouteButton.disabled = false;
  }
});

timeSlider.addEventListener('input', async () => {
  timeSliceEnabled = true;
  const hour = Number(timeSlider.value);
  const next = new Date();
  next.setMinutes(0, 0, 0);
  next.setHours(hour);
  selectedTime = next;
  updateTimeLabel();
});

timeSlider.addEventListener('change', async () => {
  try {
    await refreshMapData();
  } catch (error) {
    console.warn(error);
  }
});

layerSelect.addEventListener('change', async () => {
  try {
    await refreshMapData();
  } catch (error) {
    console.warn(error);
  }
});

resetTimeButton.addEventListener('click', async () => {
  timeSliceEnabled = false;
  selectedTime = new Date();
  timeSlider.value = String(selectedTime.getHours());
  updateTimeLabel();
  try {
    await refreshMapData();
  } catch (error) {
    console.warn(error);
  }
});

map.on('moveend', () => {
  const bounds = map.getBounds();
  bboxInput.value = [
    bounds.getWest().toFixed(4),
    bounds.getSouth().toFixed(4),
    bounds.getEast().toFixed(4),
    bounds.getNorth().toFixed(4),
  ].join(',');
  loadSummary().catch((error) => {
    console.warn(error);
  });
});

map.on('zoomend', () => {
  loadSummary().catch((error) => {
    console.warn(error);
  });
});

async function boot() {
  timeSliceEnabled = false;
  timeSlider.value = String(selectedTime.getHours());
  updateTimeLabel();
  try {
    syncRasterLayer();
    await refreshMapData();
    renderRouteNotice('Route geometry is hidden until the API returns coordinates for real segment paths.');
    await loadPersonalComparison();
  } catch (error) {
    console.warn(error);
  }
}

apiBaseInput.addEventListener('change', () => {
  syncRasterLayer();
});

// Personal Analytics Integration
const profileSelect = document.getElementById('profileSelect');
const uploadBaselineInput = document.getElementById('uploadBaseline');
const chartSvg = document.getElementById('chartSvg');
const actuatorStatus = document.getElementById('actuatorStatus');

profileSelect.addEventListener('change', () => {
  loadPersonalComparison().catch(console.warn);
});

uploadBaselineInput.addEventListener('change', (e) => {
  const file = e.target.files[0];
  if (!file) return;

  const reader = new FileReader();
  reader.onload = async function(evt) {
    try {
      const data = JSON.parse(evt.target.result);
      if (!data.profile_id || !Array.isArray(data.baselines) || data.baselines.length !== 24) {
        alert("Invalid baseline file structure. It must contain a profile_id and an array of 24 baselines.");
        return;
      }
      
      if (data.profile_id === "crop_moisture" || data.profile_id === "power_consumption") {
        profileSelect.value = data.profile_id;
      }
      
      renderUploadedBaseline(data);
    } catch (err) {
      alert("Failed to parse JSON: " + err.message);
    }
  };
  reader.readAsText(file);
});

function renderUploadedBaseline(data) {
  chartSvg.innerHTML = '';
  const width = chartSvg.clientWidth || 300;
  const height = chartSvg.clientHeight || 120;
  
  const baselines = data.baselines;
  const minVal = Math.max(0, Math.min(...baselines) - 5);
  const maxVal = Math.max(...baselines) + 5;
  const valSpan = maxVal - minVal || 1;

  const getX = (hour) => (hour / 23) * (width - 20) + 10;
  const getY = (val) => height - 10 - ((val - minVal) / valSpan) * (height - 20);

  let baselinePath = "";
  baselines.forEach((val, hour) => {
    const x = getX(hour);
    const y = getY(val);
    baselinePath += (hour === 0 ? "M" : "L") + `${x},${y}`;
  });
  
  const pathElement = document.createElementNS("http://www.w3.org/2000/svg", "path");
  pathElement.setAttribute("d", baselinePath);
  pathElement.setAttribute("fill", "none");
  pathElement.setAttribute("stroke", "#ffaa55");
  pathElement.setAttribute("stroke-width", "2.5");
  chartSvg.appendChild(pathElement);

  actuatorStatus.textContent = "Custom Profile Loaded";
  actuatorStatus.style.color = "#22c55e";
  
  const text = document.createElementNS("http://www.w3.org/2000/svg", "text");
  text.setAttribute("x", "10");
  text.setAttribute("y", "20");
  text.setAttribute("fill", "#e5eefc");
  text.setAttribute("font-size", "10px");
  text.textContent = `Baseline: ${data.metric_name}`;
  chartSvg.appendChild(text);
}

async function loadPersonalComparison() {
  const profileId = profileSelect.value;
  try {
    const data = await fetchJson(`/v1/personal/comparison?profile_id=${profileId}`);
    renderComparisonChart(data);
  } catch (error) {
    console.warn("Failed to query baseline comparisons", error);
    renderMockComparison(profileId);
  }
}

function renderComparisonChart(data) {
  chartSvg.innerHTML = '';
  const width = chartSvg.clientWidth || 300;
  const height = chartSvg.clientHeight || 120;
  
  const baselines = data.baselines || [];
  const comparisons = data.comparisons || [];
  
  if (baselines.length === 0) {
    renderMockComparison(data.profile_id);
    return;
  }

  let allVals = baselines.map(b => b.baseline_value);
  if (comparisons.length > 0) {
    allVals = allVals.concat(comparisons.map(c => c.live_value));
  }
  
  const minVal = Math.max(0, Math.min(...allVals) - 2);
  const maxVal = Math.max(...allVals) + 2;
  const valSpan = maxVal - minVal || 1;

  const getX = (hour) => (hour / 23) * (width - 20) + 10;
  const getY = (val) => height - 10 - ((val - minVal) / valSpan) * (height - 20);

  let baselinePath = "";
  baselines.forEach((b, i) => {
    const x = getX(b.hour_of_day);
    const y = getY(b.baseline_value);
    baselinePath += (i === 0 ? "M" : "L") + `${x},${y}`;
  });
  
  const pathElement = document.createElementNS("http://www.w3.org/2000/svg", "path");
  pathElement.setAttribute("d", baselinePath);
  pathElement.setAttribute("fill", "none");
  pathElement.setAttribute("stroke", "#ffaa55");
  pathElement.setAttribute("stroke-width", "2");
  pathElement.setAttribute("stroke-dasharray", "3,3");
  chartSvg.appendChild(pathElement);

  if (comparisons.length > 0) {
    let livePath = "";
    let isActuating = false;
    
    const sorted = [...comparisons].sort((a, b) => new Date(a.event_time) - new Date(b.event_time));
    
    sorted.forEach((c, i) => {
      const date = new Date(c.event_time);
      const hour = date.getHours();
      const x = getX(hour);
      const y = getY(c.live_value);
      livePath += (i === 0 ? "M" : "L") + `${x},${y}`;
      if (c.actuation_active) {
        isActuating = true;
      }
    });

    const liveElement = document.createElementNS("http://www.w3.org/2000/svg", "path");
    liveElement.setAttribute("d", livePath);
    liveElement.setAttribute("fill", "none");
    liveElement.setAttribute("stroke", "#4f8cff");
    liveElement.setAttribute("stroke-width", "2");
    chartSvg.appendChild(liveElement);

    sorted.forEach((c) => {
      if (c.actuation_active) {
        const date = new Date(c.event_time);
        const hour = date.getHours();
        const circle = document.createElementNS("http://www.w3.org/2000/svg", "circle");
        circle.setAttribute("cx", getX(hour));
        circle.setAttribute("cy", getY(c.live_value));
        circle.setAttribute("r", "4");
        circle.setAttribute("fill", "#ef4444");
        chartSvg.appendChild(circle);
      }
    });

    if (isActuating) {
      actuatorStatus.textContent = "Triggered (Alert)";
      actuatorStatus.style.color = "#ef4444";
    } else {
      actuatorStatus.textContent = "Inactive (Ok)";
      actuatorStatus.style.color = "#22c55e";
    }
  } else {
    actuatorStatus.textContent = "No Live Telemetry";
    actuatorStatus.style.color = "#8ea2c9";
  }
}

function renderMockComparison(profileId) {
  const isCrop = profileId === "crop_moisture";
  const baseline = isCrop 
    ? [45, 45, 45, 45, 46, 46, 48, 50, 52, 55, 58, 60, 60, 60, 58, 55, 52, 50, 48, 46, 46, 45, 45, 45]
    : [1.2, 1.0, 0.9, 0.9, 1.0, 1.5, 2.2, 3.5, 4.2, 3.8, 3.0, 2.8, 3.2, 3.5, 3.0, 2.8, 3.2, 4.5, 5.5, 5.8, 5.0, 3.8, 2.5, 1.8];

  const actuals = baseline.map((b, i) => {
    const variance = (Math.sin(i / 2) * (isCrop ? 4 : 0.8));
    return b + variance;
  });

  chartSvg.innerHTML = '';
  const width = chartSvg.clientWidth || 300;
  const height = chartSvg.clientHeight || 120;
  
  const minVal = Math.max(0, Math.min(...baseline, ...actuals) - 2);
  const maxVal = Math.max(...baseline, ...actuals) + 2;
  const valSpan = maxVal - minVal || 1;

  const getX = (hour) => (hour / 23) * (width - 20) + 10;
  const getY = (val) => height - 10 - ((val - minVal) / valSpan) * (height - 20);

  let baselinePath = "";
  baseline.forEach((val, hour) => {
    const x = getX(hour);
    const y = getY(val);
    baselinePath += (hour === 0 ? "M" : "L") + `${x},${y}`;
  });
  const pathElement = document.createElementNS("http://www.w3.org/2000/svg", "path");
  pathElement.setAttribute("d", baselinePath);
  pathElement.setAttribute("fill", "none");
  pathElement.setAttribute("stroke", "#ffaa55");
  pathElement.setAttribute("stroke-width", "1.5");
  pathElement.setAttribute("stroke-dasharray", "3,3");
  chartSvg.appendChild(pathElement);

  let actualsPath = "";
  actuals.forEach((val, hour) => {
    const x = getX(hour);
    const y = getY(val);
    actualsPath += (hour === 0 ? "M" : "L") + `${x},${y}`;
  });
  const actualsElement = document.createElementNS("http://www.w3.org/2000/svg", "path");
  actualsElement.setAttribute("d", actualsPath);
  actualsElement.setAttribute("fill", "none");
  actualsElement.setAttribute("stroke", "#4f8cff");
  actualsElement.setAttribute("stroke-width", "2");
  chartSvg.appendChild(actualsElement);

  actuatorStatus.textContent = "Offline (Mock Data)";
  actuatorStatus.style.color = "#8ea2c9";
}

setInterval(() => {
  loadPersonalComparison().catch(console.warn);
}, 3000);

boot();
