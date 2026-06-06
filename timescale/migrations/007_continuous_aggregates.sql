-- Create a continuous aggregate for city-minute rollups
-- This view groups raw observations into 1-minute buckets for fast read queries.
-- Apply with psql against your TimescaleDB; requires timescaledb extension.

CREATE MATERIALIZED VIEW IF NOT EXISTS weather_city_minute_cagg
WITH (timescaledb.continuous) AS
SELECT
    time_bucket('1 minute', event_time) AS bucket,
    continent,
    country,
    region,
    city,
    count(*) AS sample_count,
    min(temperature) AS min_temperature,
    max(temperature) AS max_temperature,
    avg(temperature) AS avg_temperature,
    avg(humidity) AS avg_humidity,
    avg(wind_speed) AS avg_wind_speed,
    avg(pressure_hpa) AS avg_pressure_hpa
FROM weather_observations_raw
GROUP BY bucket, continent, country, region, city;

-- Helpful index for common queries
CREATE INDEX IF NOT EXISTS ON weather_city_minute_cagg (bucket DESC, continent, country, region, city);

-- Add a continuous aggregate refresh policy: keep the last hour materialized and refresh frequently
SELECT add_continuous_aggregate_policy('weather_city_minute_cagg',
    start_interval => INTERVAL '1 hour',
    end_interval => INTERVAL '1 minute',
    schedule_interval => INTERVAL '30 seconds');
