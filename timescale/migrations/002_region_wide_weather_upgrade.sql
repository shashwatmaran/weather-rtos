-- Apply to an existing database after timescale/schema.sql and timescale/map_phase1.sql.
-- Adds raw pressure/geospatial columns and makes the tile aggregates pressure-aware.

ALTER TABLE weather_observations_raw
    ADD COLUMN IF NOT EXISTS latitude DOUBLE PRECISION,
    ADD COLUMN IF NOT EXISTS longitude DOUBLE PRECISION,
    ADD COLUMN IF NOT EXISTS visibility_km DOUBLE PRECISION,
    ADD COLUMN IF NOT EXISTS precipitation_mm DOUBLE PRECISION,
    ADD COLUMN IF NOT EXISTS pressure_hpa DOUBLE PRECISION,
    ADD COLUMN IF NOT EXISTS cloud_cover_percent DOUBLE PRECISION,
    ADD COLUMN IF NOT EXISTS station_id TEXT;

ALTER TABLE weather_tile_minute_aggregates
    ADD COLUMN IF NOT EXISTS avg_pressure_hpa DOUBLE PRECISION;

-- Rebuild indexes only if you changed bucket/tile patterns materially.
-- No index changes are required for this upgrade.
