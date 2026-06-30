/* ============================================================
   Weather RTOS — Historical Dashboard Application
   ============================================================ */

// ---- DOM References ----
const apiBaseInput = document.getElementById('apiBase');
const citySelect = document.getElementById('citySelect');
const metricChecks = document.getElementById('metricChecks');
const dateFrom = document.getElementById('dateFrom');
const dateTo = document.getElementById('dateTo');
const intervalSelect = document.getElementById('intervalSelect');
const btnFetchData = document.getElementById('btnFetchData');
const emptyState = document.getElementById('emptyState');
const loadingOverlay = document.getElementById('loadingOverlay');
const sourceBadge = document.getElementById('sourceBadge');
const sourceLabel = document.getElementById('sourceLabel');

// Stats
const statMinTemp = document.getElementById('statMinTemp');
const statMaxTemp = document.getElementById('statMaxTemp');
const statAvgTemp = document.getElementById('statAvgTemp');
const statAvgHumidity = document.getElementById('statAvgHumidity');
const statAvgWind = document.getElementById('statAvgWind');
const statObservations = document.getElementById('statObservations');

// Comparison tab
const dropzone = document.getElementById('dropzone');
const fileInput = document.getElementById('fileInput');
const uploadInfo = document.getElementById('uploadInfo');
const uploadFileName = document.getElementById('uploadFileName');
const uploadFileRows = document.getElementById('uploadFileRows');
const mappingPanel = document.getElementById('mappingPanel');
const mappingGrid = document.getElementById('mappingGrid');
const compCityPanel = document.getElementById('comparisonCityPanel');
const compCitySelect = document.getElementById('compCitySelect');
const compWeatherMetricPanel = document.getElementById('compWeatherMetricPanel');
const compWeatherMetric = document.getElementById('compWeatherMetric');
const compDataLabelPanel = document.getElementById('compDataLabel');
const compUserLabel = document.getElementById('compUserLabel');
const compActions = document.getElementById('compActions');
const btnRunComparison = document.getElementById('btnRunComparison');
const compLegend = document.getElementById('compLegend');
const compCorrelation = document.getElementById('compCorrelation');
const corrValue = document.getElementById('corrValue');
const corrLabel = document.getElementById('corrLabel');
const legendUserLabel = document.getElementById('legendUserLabel');
const compChartContainer = document.getElementById('compChartContainer');

// Tabs
const tabExplorer = document.getElementById('tabExplorer');
const tabComparison = document.getElementById('tabComparison');
const panelExplorer = document.getElementById('panelExplorer');
const panelComparison = document.getElementById('panelComparison');

// Charts
const mainChartCanvas = document.getElementById('mainChart');
const compChartCanvas = document.getElementById('compChart');

// ---- State ----
let mainChart = null;
let compChart = null;
let uploadedData = null;
let uploadedColumns = [];
let activeTab = 'explorer';
let lastExplorerTsData = null;

// ---- API ----
function apiBase() {
  return apiBaseInput.value.replace(/\/$/, '');
}

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

// ---- Defaults ----
function setDefaultDates() {
  const now = new Date();
  const yesterday = new Date(now);
  yesterday.setDate(yesterday.getDate() - 1);
  dateFrom.value = yesterday.toISOString().split('T')[0];
  dateTo.value = now.toISOString().split('T')[0];
}
setDefaultDates();

// ---- Tab Navigation ----
function switchTab(tab) {
  activeTab = tab;
  document.querySelectorAll('.tab-btn').forEach(b => b.classList.remove('active'));
  document.querySelectorAll('.tab-panel').forEach(p => p.classList.remove('active'));

  if (tab === 'explorer') {
    tabExplorer.classList.add('active');
    panelExplorer.classList.add('active');
    compChartContainer.style.display = 'none';
    document.getElementById('chartContainer').style.flex = '1';
  } else {
    tabComparison.classList.add('active');
    panelComparison.classList.add('active');
  }
}

tabExplorer.addEventListener('click', () => switchTab('explorer'));
tabComparison.addEventListener('click', () => switchTab('comparison'));

// ---- Metric Chips ----
metricChecks.querySelectorAll('.chip').forEach(chip => {
  chip.addEventListener('click', (e) => {
    e.preventDefault();
    const checkbox = chip.querySelector('input[type="checkbox"]');
    checkbox.checked = !checkbox.checked;
    chip.classList.toggle('active', checkbox.checked);
    if (lastExplorerTsData) {
      renderExplorerChart(lastExplorerTsData, getSelectedMetrics());
    }
  });
});

function getSelectedMetrics() {
  const metrics = [];
  metricChecks.querySelectorAll('.chip').forEach(chip => {
    if (chip.classList.contains('active')) {
      metrics.push(chip.dataset.metric);
    }
  });
  return metrics.length > 0 ? metrics : ['avg_temperature'];
}

// ---- Fetch Cities ----
async function fetchCities() {
  try {
    const res = await fetch(`${apiBase()}/v1/history/cities`);
    const data = await res.json();
    const cities = data.cities || [];

    citySelect.innerHTML = '';
    compCitySelect.innerHTML = '';
    cities.forEach(c => {
      const opt = document.createElement('option');
      opt.value = c.city;
      opt.textContent = `${c.city} — ${c.region}, ${c.country}`;
      citySelect.appendChild(opt);

      const opt2 = opt.cloneNode(true);
      compCitySelect.appendChild(opt2);
    });

    if (cities.length === 0) {
      citySelect.innerHTML = '<option value="">No cities available</option>';
      compCitySelect.innerHTML = '<option value="">No cities available</option>';
    }
  } catch (err) {
    console.error('Failed to fetch cities:', err);
    citySelect.innerHTML = '<option value="Bangalore">Bangalore (offline)</option>';
    compCitySelect.innerHTML = '<option value="Bangalore">Bangalore (offline)</option>';
  }
}

// ---- Chart.js Configuration ----
const METRIC_CONFIG = {
  avg_temperature: {
    label: 'Temperature (°C)',
    color: '#4f8cff',
    bgColor: 'rgba(79, 140, 255, 0.08)',
    yAxisID: 'y',
    unit: '°C',
  },
  avg_humidity: {
    label: 'Humidity (%)',
    color: '#22c55e',
    bgColor: 'rgba(34, 197, 94, 0.08)',
    yAxisID: 'y1',
    unit: '%',
  },
  avg_wind_speed: {
    label: 'Wind Speed (km/h)',
    color: '#a78bfa',
    bgColor: 'rgba(167, 139, 250, 0.08)',
    yAxisID: 'y2',
    unit: ' km/h',
  },
};

function chartBaseOptions() {
  return {
    responsive: true,
    maintainAspectRatio: false,
    interaction: {
      mode: 'index',
      intersect: false,
    },
    plugins: {
      legend: {
        display: true,
        position: 'top',
        labels: {
          color: '#8ea2c9',
          font: { family: 'Inter', size: 12, weight: '500' },
          padding: 20,
          usePointStyle: true,
          pointStyleWidth: 16,
        },
      },
      tooltip: {
        backgroundColor: 'rgba(10, 18, 34, 0.95)',
        titleColor: '#e5eefc',
        bodyColor: '#c0cfe2',
        borderColor: 'rgba(148, 163, 184, 0.2)',
        borderWidth: 1,
        cornerRadius: 12,
        padding: 14,
        titleFont: { family: 'Inter', size: 13, weight: '600' },
        bodyFont: { family: 'Inter', size: 12 },
        displayColors: true,
        boxPadding: 4,
      },
    },
    scales: {
      x: {
        type: 'category',
        grid: {
          color: 'rgba(148, 163, 184, 0.06)',
          drawBorder: false,
        },
        ticks: {
          color: '#8ea2c9',
          font: { family: 'Inter', size: 11 },
          maxRotation: 45,
          maxTicksLimit: 20,
        },
      },
    },
    animation: {
      duration: 800,
      easing: 'easeOutQuart',
    },
  };
}

function buildYAxes(metrics) {
  const axes = {};
  const positions = ['left', 'right', 'right'];
  let idx = 0;
  metrics.forEach(m => {
    const config = METRIC_CONFIG[m];
    if (!config) return;
    axes[config.yAxisID] = {
      type: 'linear',
      position: positions[idx] || 'right',
      display: true,
      grid: {
        color: idx === 0 ? 'rgba(148, 163, 184, 0.08)' : 'transparent',
        drawBorder: false,
      },
      ticks: {
        color: config.color,
        font: { family: 'Inter', size: 11 },
        callback: (val) => val.toFixed(1) + config.unit,
      },
      title: {
        display: true,
        text: config.label,
        color: config.color,
        font: { family: 'Inter', size: 12, weight: '600' },
      },
    };
    idx++;
  });
  return axes;
}

// ---- Format Timestamps ----
function formatTimestamp(ts) {
  const d = (typeof ts === 'number') ? new Date(ts) : new Date(ts);
  if (isNaN(d.getTime())) return String(ts);
  const month = String(d.getMonth() + 1).padStart(2, '0');
  const day = String(d.getDate()).padStart(2, '0');
  const hour = String(d.getHours()).padStart(2, '0');
  const min = String(d.getMinutes()).padStart(2, '0');
  return `${month}/${day} ${hour}:${min}`;
}

// ---- Fetch & Render Explorer Data ----
async function fetchAndRenderExplorer() {
  const city = citySelect.value;
  if (!city) return;

  const from = dateFrom.value;
  const to = dateTo.value;
  const interval = intervalSelect.value;
  const metrics = getSelectedMetrics();

  loadingOverlay.style.display = 'flex';
  emptyState.classList.add('hidden');

  try {
    const params = new URLSearchParams({ city });
    if (from) params.set('from', from);
    if (to) params.set('to', to + 'T23:59:59');
    if (interval) params.set('interval', interval);

    const [tsRes, sumRes] = await Promise.all([
      fetch(`${apiBase()}/v1/history/timeseries?${params}`),
      fetch(`${apiBase()}/v1/history/summary?${params}`),
    ]);

    const tsData = await tsRes.json();
    const sumData = await sumRes.json();

    lastExplorerTsData = tsData;

    renderExplorerChart(tsData, metrics);
    renderStats(sumData);
    updateSourceBadge(tsData.source);
  } catch (err) {
    console.error('Failed to fetch data:', err);
    updateSourceBadge('error');
  } finally {
    loadingOverlay.style.display = 'none';
  }
}

function renderExplorerChart(tsData, metrics) {
  const rows = tsData.data || [];
  const labels = rows.map(r => formatTimestamp(r.ts));

  const datasets = metrics.map(metric => {
    const config = METRIC_CONFIG[metric];
    if (!config) return null;
    return {
      label: config.label,
      data: rows.map(r => r[metric] != null ? Number(r[metric]) : null),
      borderColor: config.color,
      backgroundColor: config.bgColor,
      fill: true,
      tension: 0.35,
      borderWidth: 2.5,
      pointRadius: rows.length > 80 ? 0 : 3,
      pointHoverRadius: 5,
      pointBackgroundColor: config.color,
      yAxisID: config.yAxisID,
    };
  }).filter(Boolean);

  // Add min/max temperature band if temperature is selected
  if (metrics.includes('avg_temperature') && rows.length > 0 && rows[0].min_temperature != null) {
    datasets.push({
      label: 'Temp range (min–max)',
      data: rows.map(r => r.max_temperature != null ? Number(r.max_temperature) : null),
      borderColor: 'rgba(79, 140, 255, 0.25)',
      backgroundColor: 'rgba(79, 140, 255, 0.06)',
      fill: '+1',
      tension: 0.35,
      borderWidth: 1,
      pointRadius: 0,
      yAxisID: 'y',
    });
    datasets.push({
      label: 'Temp min',
      data: rows.map(r => r.min_temperature != null ? Number(r.min_temperature) : null),
      borderColor: 'rgba(79, 140, 255, 0.25)',
      backgroundColor: 'transparent',
      fill: false,
      tension: 0.35,
      borderWidth: 1,
      pointRadius: 0,
      yAxisID: 'y',
      hidden: true,
    });
  }

  const options = chartBaseOptions();
  options.scales = { ...options.scales, ...buildYAxes(metrics) };

  if (mainChart) {
    mainChart.destroy();
  }

  mainChart = new Chart(mainChartCanvas, {
    type: 'line',
    data: { labels, datasets },
    options,
  });
}

function renderStats(sumData) {
  const fmt = (v) => v != null ? Number(v).toFixed(1) : '—';
  statMinTemp.textContent = fmt(sumData.min_temperature) + '°C';
  statMaxTemp.textContent = fmt(sumData.max_temperature) + '°C';
  statAvgTemp.textContent = fmt(sumData.avg_temperature) + '°C';
  statAvgHumidity.textContent = fmt(sumData.avg_humidity) + '%';
  statAvgWind.textContent = fmt(sumData.avg_wind_speed) + ' km/h';
  statObservations.textContent = sumData.observation_count != null ? Number(sumData.observation_count).toLocaleString() : '—';
}

function updateSourceBadge(source) {
  sourceBadge.classList.remove('live', 'fallback');
  if (source === 'timescale') {
    sourceBadge.classList.add('live');
    sourceLabel.textContent = 'Connected to TimescaleDB';
  } else if (source === 'live_unavailable') {
    sourceBadge.classList.add('fallback');
    sourceLabel.textContent = 'Using sample data (DB offline)';
  } else {
    sourceLabel.textContent = 'Connection error';
  }
}

// ---- Event Listeners (Explorer) ----
btnFetchData.addEventListener('click', fetchAndRenderExplorer);

// ========================================================
// COMPARISON TAB — Upload ANY data and overlay vs weather
// ========================================================

// ---- Drag & Drop ----
['dragenter', 'dragover'].forEach(evt => {
  dropzone.addEventListener(evt, (e) => {
    e.preventDefault();
    dropzone.classList.add('dragover');
  });
});

['dragleave', 'drop'].forEach(evt => {
  dropzone.addEventListener(evt, () => {
    dropzone.classList.remove('dragover');
  });
});

dropzone.addEventListener('drop', (e) => {
  e.preventDefault();
  const file = e.dataTransfer.files[0];
  if (file) handleFileUpload(file);
});

fileInput.addEventListener('change', () => {
  if (fileInput.files[0]) handleFileUpload(fileInput.files[0]);
});

// ---- File Upload ----
function handleFileUpload(file) {
  const reader = new FileReader();
  reader.onload = (e) => {
    const text = e.target.result;
    const ext = file.name.split('.').pop().toLowerCase();

    let parsed;
    if (ext === 'json') {
      parsed = parseJsonFile(text);
    } else {
      parsed = parseCsvFile(text);
    }

    if (!parsed || parsed.rows.length === 0) {
      alert('Could not parse the file or no data found.');
      return;
    }

    uploadedData = parsed;
    uploadedColumns = parsed.columns;

    // Show upload info
    uploadInfo.style.display = 'block';
    uploadFileName.textContent = file.name;
    uploadFileRows.textContent = `${parsed.rows.length} rows, ${parsed.columns.length} columns`;

    // Build mapping UI
    buildMappingUI(parsed.columns);
    mappingPanel.style.display = 'block';
    compCityPanel.style.display = 'block';
    compWeatherMetricPanel.style.display = 'block';
    compDataLabelPanel.style.display = 'block';
    compActions.style.display = 'block';

    // Try to auto-fill a label from the value column name
    const guessedValue = guessValueColumn(parsed.columns);
    if (guessedValue) {
      compUserLabel.value = guessedValue;
    }
  };
  reader.readAsText(file);
}

function parseCsvFile(text) {
  const lines = text.trim().split('\n');
  if (lines.length < 2) return null;

  const headers = lines[0].split(',').map(h => h.trim().replace(/^"|"$/g, ''));
  const rows = [];
  for (let i = 1; i < lines.length; i++) {
    const values = parseCSVLine(lines[i]);
    if (values.length === headers.length) {
      const row = {};
      headers.forEach((h, idx) => {
        row[h] = values[idx];
      });
      rows.push(row);
    }
  }

  return { columns: headers, rows };
}

function parseCSVLine(line) {
  const result = [];
  let current = '';
  let inQuotes = false;

  for (let i = 0; i < line.length; i++) {
    const char = line[i];
    if (char === '"') {
      inQuotes = !inQuotes;
    } else if (char === ',' && !inQuotes) {
      result.push(current.trim());
      current = '';
    } else {
      current += char;
    }
  }
  result.push(current.trim());
  return result;
}

function parseJsonFile(text) {
  try {
    let data = JSON.parse(text);
    // Support { data: [...] } and [...] formats
    if (data.data && Array.isArray(data.data)) {
      data = data.data;
    }
    if (!Array.isArray(data) || data.length === 0) return null;

    const columns = Object.keys(data[0]);
    return { columns, rows: data };
  } catch {
    return null;
  }
}

// ---- Mapping UI ----
// For the generic comparison, we only need: timestamp + value
const EXPECTED_FIELDS = [
  { key: 'timestamp', label: 'Timestamp', required: true },
  { key: 'value', label: 'Your value', required: true },
];

function buildMappingUI(columns) {
  mappingGrid.innerHTML = '';

  EXPECTED_FIELDS.forEach(field => {
    const row = document.createElement('div');
    row.className = 'mapping-row';

    const labelDiv = document.createElement('div');
    labelDiv.className = 'field-label';
    labelDiv.textContent = field.label + (field.required ? ' *' : '');

    const arrowDiv = document.createElement('div');
    arrowDiv.className = 'arrow';
    arrowDiv.textContent = '←';

    const select = document.createElement('select');
    select.dataset.field = field.key;

    const noneOpt = document.createElement('option');
    noneOpt.value = '';
    noneOpt.textContent = '— select —';
    select.appendChild(noneOpt);

    columns.forEach(col => {
      const opt = document.createElement('option');
      opt.value = col;
      opt.textContent = col;
      // Auto-detect matching columns
      if (autoMatchColumn(field.key, col)) {
        opt.selected = true;
      }
      select.appendChild(opt);
    });

    row.appendChild(labelDiv);
    row.appendChild(arrowDiv);
    row.appendChild(select);
    mappingGrid.appendChild(row);
  });
}

function autoMatchColumn(field, column) {
  const c = column.toLowerCase();
  const aliases = {
    timestamp: ['timestamp', 'time', 'date', 'datetime', 'ts', 'event_time', 'bucket_start', 'date_time', 'recorded_at'],
    value: [], // Don't auto-match value — user should pick, but we'll guess in guessValueColumn
  };
  return (aliases[field] || []).includes(c);
}

function guessValueColumn(columns) {
  // Auto-select the first non-timestamp-looking column as the value
  const timestampLike = ['timestamp', 'time', 'date', 'datetime', 'ts', 'event_time', 'bucket_start', 'date_time', 'recorded_at'];
  for (const col of columns) {
    if (!timestampLike.includes(col.toLowerCase())) {
      // Auto-select it in the mapping
      const selects = mappingGrid.querySelectorAll('select');
      selects.forEach(sel => {
        if (sel.dataset.field === 'value') {
          sel.value = col;
        }
      });
      // Use the column name as the label
      return col.replace(/_/g, ' ').replace(/\b\w/g, l => l.toUpperCase());
    }
  }
  return '';
}

function getColumnMapping() {
  const mapping = {};
  mappingGrid.querySelectorAll('select').forEach(sel => {
    if (sel.value) {
      mapping[sel.dataset.field] = sel.value;
    }
  });
  return mapping;
}

// ---- Comparison Logic ----
btnRunComparison.addEventListener('click', runComparison);

async function runComparison() {
  if (!uploadedData) return;

  const mapping = getColumnMapping();
  if (!mapping.timestamp || !mapping.value) {
    alert('Please map both the "Timestamp" and "Your value" columns.');
    return;
  }

  const city = compCitySelect.value;
  if (!city) return;

  const weatherMetricKey = compWeatherMetric.value;
  const userLabel = compUserLabel.value || 'Your Data';

  // Update legend
  legendUserLabel.textContent = userLabel;

  // Parse uploaded timestamps & values
  const uploadRows = uploadedData.rows.map(r => {
    const ts = parseAnyTimestamp(r[mapping.timestamp]);
    const val = parseFloat(r[mapping.value]);
    return { ts, value: val };
  }).filter(r => r.ts != null && !isNaN(r.value)).sort((a, b) => a.ts - b.ts);

  if (uploadRows.length === 0) {
    alert('Could not parse any valid rows from the uploaded data. Check your column mapping.');
    return;
  }

  const minTs = new Date(uploadRows[0].ts);
  const maxTs = new Date(uploadRows[uploadRows.length - 1].ts);

  // Fetch weather data for the same range
  loadingOverlay.style.display = 'flex';
  emptyState.classList.add('hidden');

  try {
    const params = new URLSearchParams({
      city,
      from: minTs.toISOString(),
      to: maxTs.toISOString(),
      interval: '1 hour',
    });

    const res = await fetch(`${apiBase()}/v1/history/timeseries?${params}`);
    const sysData = await res.json();

    renderCorrelationChart(sysData, uploadRows, weatherMetricKey, userLabel, city);
  } catch (err) {
    console.error('Comparison fetch failed:', err);
    alert('Failed to fetch weather data for comparison.');
  } finally {
    loadingOverlay.style.display = 'none';
  }
}

function parseAnyTimestamp(value) {
  if (value == null) return null;
  // Epoch millis
  const asNum = Number(value);
  if (!isNaN(asNum) && asNum > 1e9) {
    return asNum > 1e12 ? asNum : asNum * 1000; // sec vs ms
  }
  // ISO / date string
  const d = new Date(value);
  return isNaN(d.getTime()) ? null : d.getTime();
}

function bucketHour(ts) {
  return Math.floor(ts / 3600000) * 3600000;
}

// ---- Pearson Correlation ----
function pearsonCorrelation(xs, ys) {
  const n = xs.length;
  if (n < 2) return 0;

  let sumX = 0, sumY = 0, sumXY = 0, sumX2 = 0, sumY2 = 0;
  for (let i = 0; i < n; i++) {
    sumX += xs[i];
    sumY += ys[i];
    sumXY += xs[i] * ys[i];
    sumX2 += xs[i] * xs[i];
    sumY2 += ys[i] * ys[i];
  }

  const numerator = n * sumXY - sumX * sumY;
  const denominator = Math.sqrt((n * sumX2 - sumX * sumX) * (n * sumY2 - sumY * sumY));

  if (denominator === 0) return 0;
  return numerator / denominator;
}

// ---- Render Correlation Chart ----
function renderCorrelationChart(sysData, uploadRows, weatherMetricKey, userLabel, city) {
  const weatherConfig = METRIC_CONFIG[weatherMetricKey];
  const weatherLabel = weatherConfig ? weatherConfig.label : 'Weather';

  // Build weather data map (bucketed by hour)
  const sysRows = (sysData.data || []).map(r => ({
    ts: typeof r.ts === 'number' ? r.ts : new Date(r.ts).getTime(),
    value: Number(r[weatherMetricKey]),
  })).filter(r => !isNaN(r.ts) && !isNaN(r.value));

  const sysMap = new Map();
  sysRows.forEach(r => {
    const b = bucketHour(r.ts);
    if (!sysMap.has(b)) sysMap.set(b, []);
    sysMap.get(b).push(r.value);
  });

  // Build upload data map (bucketed by hour)
  const uploadMap = new Map();
  uploadRows.forEach(r => {
    const b = bucketHour(r.ts);
    if (!uploadMap.has(b)) uploadMap.set(b, []);
    uploadMap.get(b).push(r.value);
  });

  // Unified timeline
  const allBuckets = new Set();
  sysMap.forEach((_, b) => allBuckets.add(b));
  uploadMap.forEach((_, b) => allBuckets.add(b));
  const sortedBuckets = [...allBuckets].sort((a, b) => a - b);

  const labels = sortedBuckets.map(b => formatTimestamp(b));
  const weatherValues = sortedBuckets.map(b => {
    const vals = sysMap.get(b);
    return vals ? vals.reduce((a, c) => a + c, 0) / vals.length : null;
  });
  const userValues = sortedBuckets.map(b => {
    const vals = uploadMap.get(b);
    return vals ? vals.reduce((a, c) => a + c, 0) / vals.length : null;
  });

  // Calculate correlation on paired non-null values
  const pairedWeather = [];
  const pairedUser = [];
  for (let i = 0; i < sortedBuckets.length; i++) {
    if (weatherValues[i] != null && userValues[i] != null) {
      pairedWeather.push(weatherValues[i]);
      pairedUser.push(userValues[i]);
    }
  }

  const r = pearsonCorrelation(pairedWeather, pairedUser);
  showCorrelation(r, pairedWeather.length);

  // Show chart areas
  compChartContainer.style.display = 'flex';
  document.getElementById('chartContainer').style.flex = '1';
  compLegend.style.display = 'flex';

  // ---- Main chart: dual-axis overlay ----
  const mainOptions = chartBaseOptions();
  mainOptions.scales.y = {
    type: 'linear',
    position: 'left',
    grid: { color: 'rgba(148, 163, 184, 0.08)', drawBorder: false },
    ticks: {
      color: '#ff7a59',
      font: { family: 'Inter', size: 11 },
    },
    title: {
      display: true,
      text: userLabel,
      color: '#ff7a59',
      font: { family: 'Inter', size: 12, weight: '600' },
    },
  };
  mainOptions.scales.y1 = {
    type: 'linear',
    position: 'right',
    grid: { drawOnChartArea: false, drawBorder: false },
    ticks: {
      color: weatherConfig ? weatherConfig.color : '#4f8cff',
      font: { family: 'Inter', size: 11 },
    },
    title: {
      display: true,
      text: `${weatherLabel} — ${city}`,
      color: weatherConfig ? weatherConfig.color : '#4f8cff',
      font: { family: 'Inter', size: 12, weight: '600' },
    },
  };

  if (mainChart) mainChart.destroy();
  mainChart = new Chart(mainChartCanvas, {
    type: 'line',
    data: {
      labels,
      datasets: [
        {
          label: userLabel,
          data: userValues,
          borderColor: '#ff7a59',
          backgroundColor: 'rgba(255, 122, 89, 0.08)',
          fill: true,
          tension: 0.35,
          borderWidth: 2.5,
          pointRadius: labels.length > 80 ? 0 : 3,
          pointHoverRadius: 5,
          pointBackgroundColor: '#ff7a59',
          yAxisID: 'y',
        },
        {
          label: `${weatherLabel} — ${city}`,
          data: weatherValues,
          borderColor: weatherConfig ? weatherConfig.color : '#4f8cff',
          backgroundColor: weatherConfig ? weatherConfig.bgColor : 'rgba(79, 140, 255, 0.08)',
          fill: true,
          tension: 0.35,
          borderWidth: 2.5,
          pointRadius: labels.length > 80 ? 0 : 3,
          pointHoverRadius: 5,
          pointBackgroundColor: weatherConfig ? weatherConfig.color : '#4f8cff',
          yAxisID: 'y1',
        },
      ],
    },
    options: mainOptions,
  });

  // ---- Bottom chart: scatter plot for correlation visual ----
  const compOptions = chartBaseOptions();
  compOptions.plugins.legend.display = true;
  compOptions.scales = {
    x: {
      type: 'linear',
      title: {
        display: true,
        text: weatherLabel,
        color: weatherConfig ? weatherConfig.color : '#4f8cff',
        font: { family: 'Inter', size: 12, weight: '600' },
      },
      grid: { color: 'rgba(148, 163, 184, 0.08)', drawBorder: false },
      ticks: { color: '#8ea2c9', font: { family: 'Inter', size: 11 } },
    },
    y: {
      type: 'linear',
      title: {
        display: true,
        text: userLabel,
        color: '#ff7a59',
        font: { family: 'Inter', size: 12, weight: '600' },
      },
      grid: { color: 'rgba(148, 163, 184, 0.08)', drawBorder: false },
      ticks: { color: '#8ea2c9', font: { family: 'Inter', size: 11 } },
    },
  };

  const scatterData = pairedWeather.map((w, i) => ({ x: w, y: pairedUser[i] }));

  // Calculate trendline
  let trendline = [];
  if (pairedWeather.length >= 2) {
    const { slope, intercept } = linearRegression(pairedWeather, pairedUser);
    const minW = Math.min(...pairedWeather);
    const maxW = Math.max(...pairedWeather);
    trendline = [
      { x: minW, y: slope * minW + intercept },
      { x: maxW, y: slope * maxW + intercept },
    ];
  }

  if (compChart) compChart.destroy();
  compChart = new Chart(compChartCanvas, {
    type: 'scatter',
    data: {
      datasets: [
        {
          label: 'Data points',
          data: scatterData,
          backgroundColor: 'rgba(255, 122, 89, 0.6)',
          borderColor: '#ff7a59',
          pointRadius: 5,
          pointHoverRadius: 7,
        },
        {
          label: `Trendline (r = ${r.toFixed(3)})`,
          data: trendline,
          type: 'line',
          borderColor: 'rgba(245, 158, 11, 0.8)',
          borderWidth: 2,
          borderDash: [6, 4],
          pointRadius: 0,
          fill: false,
          tension: 0,
        },
      ],
    },
    options: compOptions,
  });
}

function linearRegression(xs, ys) {
  const n = xs.length;
  let sumX = 0, sumY = 0, sumXY = 0, sumX2 = 0;
  for (let i = 0; i < n; i++) {
    sumX += xs[i];
    sumY += ys[i];
    sumXY += xs[i] * ys[i];
    sumX2 += xs[i] * xs[i];
  }
  const slope = (n * sumXY - sumX * sumY) / (n * sumX2 - sumX * sumX);
  const intercept = (sumY - slope * sumX) / n;
  return { slope, intercept };
}

function showCorrelation(r, pairCount) {
  compCorrelation.style.display = 'block';

  const rAbs = Math.abs(r);
  corrValue.textContent = r.toFixed(3);
  corrValue.className = 'corr-value';

  if (rAbs >= 0.5) {
    corrValue.classList.add(r > 0 ? 'positive' : 'negative');
  } else {
    corrValue.classList.add('weak');
  }

  let strength = 'No';
  if (rAbs >= 0.8) strength = 'Strong';
  else if (rAbs >= 0.5) strength = 'Moderate';
  else if (rAbs >= 0.3) strength = 'Weak';

  const direction = r >= 0 ? 'positive' : 'negative';
  corrLabel.textContent = `${strength} ${direction} correlation · ${pairCount} matched points`;
}

// ---- Init ----
async function init() {
  await fetchCities();
  // Auto-fetch data for the first city on load
  if (citySelect.value) {
    fetchAndRenderExplorer();
  }
}

init();

// Auto-poll every 30 seconds when on the Explorer tab
setInterval(() => {
  if (activeTab === 'explorer' && citySelect.value) {
    fetchAndRenderExplorer();
  }
}, 30000);

