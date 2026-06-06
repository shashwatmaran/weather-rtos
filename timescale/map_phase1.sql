-- Phase 1 map analytics schema extensions for logistics use case.
-- Apply after timescale/schema.sql.

CREATE TABLE IF NOT EXISTS weather_tile_minute_aggregates (
    bucket_start TIMESTAMPTZ NOT NULL,
    tile_id TEXT NOT NULL,
    continent TEXT NOT NULL,
    country TEXT NOT NULL,
    region TEXT NOT NULL,
    latitude DOUBLE PRECISION,
    longitude DOUBLE PRECISION,
    sample_count BIGINT NOT NULL,
    avg_temperature DOUBLE PRECISION NOT NULL,
    avg_humidity DOUBLE PRECISION NOT NULL,
    avg_cloud_cover DOUBLE PRECISION,
    avg_wind_speed DOUBLE PRECISION NOT NULL,
    avg_pressure_hpa DOUBLE PRECISION,
    min_visibility_km DOUBLE PRECISION,
    max_precipitation_mm DOUBLE PRECISION,
    hazard_score DOUBLE PRECISION NOT NULL,
    PRIMARY KEY (bucket_start, tile_id, region)
);

SELECT create_hypertable('weather_tile_minute_aggregates', 'bucket_start', if_not_exists => TRUE);

CREATE INDEX IF NOT EXISTS idx_tile_agg_region_bucket
    ON weather_tile_minute_aggregates (region, bucket_start DESC);

CREATE INDEX IF NOT EXISTS idx_tile_agg_tile_bucket
    ON weather_tile_minute_aggregates (tile_id, bucket_start DESC);

CREATE TABLE IF NOT EXISTS route_segment_risk_minute (
    bucket_start TIMESTAMPTZ NOT NULL,
    route_id TEXT NOT NULL,
    segment_id TEXT NOT NULL,
    region TEXT NOT NULL,
    hazard_score DOUBLE PRECISION NOT NULL,
    delay_factor DOUBLE PRECISION NOT NULL,
    primary_hazard TEXT NOT NULL,
    PRIMARY KEY (bucket_start, route_id, segment_id)
);

SELECT create_hypertable('route_segment_risk_minute', 'bucket_start', if_not_exists => TRUE);

CREATE INDEX IF NOT EXISTS idx_route_risk_route_bucket
    ON route_segment_risk_minute (route_id, bucket_start DESC);

CREATE INDEX IF NOT EXISTS idx_route_risk_region_bucket
    ON route_segment_risk_minute (region, bucket_start DESC);
