ALTER TABLE IF EXISTS weather_observations_raw
    ADD COLUMN IF NOT EXISTS ingest_layer TEXT;

ALTER TABLE IF EXISTS weather_observations_raw
    ADD COLUMN IF NOT EXISTS sample_point TEXT;