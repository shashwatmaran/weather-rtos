-- Phase 1 storage policies for sustained streaming ingest.
-- Apply after timescale/schema.sql, timescale/map_phase1.sql, and the earlier migrations.

-- Raw observations: hot for a short period, then compressed, then dropped.
ALTER TABLE weather_observations_raw
    SET (
        timescaledb.compress,
        timescaledb.compress_segmentby = 'continent, country, region, city, station_id'
    );

SELECT set_chunk_time_interval('weather_observations_raw', INTERVAL '1 day');
SELECT add_compression_policy('weather_observations_raw', INTERVAL '7 days');
SELECT add_retention_policy('weather_observations_raw', INTERVAL '90 days');

-- City aggregates stay longer than raw telemetry.
ALTER TABLE weather_city_minute_aggregates
    SET (
        timescaledb.compress,
        timescaledb.compress_segmentby = 'continent, country, region, city'
    );

SELECT set_chunk_time_interval('weather_city_minute_aggregates', INTERVAL '7 days');
SELECT add_compression_policy('weather_city_minute_aggregates', INTERVAL '30 days');
SELECT add_retention_policy('weather_city_minute_aggregates', INTERVAL '365 days');

-- Tile and route risk tables support map reads and operational summaries.
ALTER TABLE weather_tile_minute_aggregates
    SET (
        timescaledb.compress,
        timescaledb.compress_segmentby = 'tile_id, continent, country, region'
    );

SELECT set_chunk_time_interval('weather_tile_minute_aggregates', INTERVAL '7 days');
SELECT add_compression_policy('weather_tile_minute_aggregates', INTERVAL '30 days');
SELECT add_retention_policy('weather_tile_minute_aggregates', INTERVAL '365 days');

ALTER TABLE route_segment_risk_minute
    SET (
        timescaledb.compress,
        timescaledb.compress_segmentby = 'route_id, segment_id, region'
    );

SELECT set_chunk_time_interval('route_segment_risk_minute', INTERVAL '7 days');
SELECT add_compression_policy('route_segment_risk_minute', INTERVAL '30 days');
SELECT add_retention_policy('route_segment_risk_minute', INTERVAL '365 days');