-- Rasterize weather_tile_minute_aggregates into cached 256x256 WebMercator tiles
-- Uses inverse-distance weighting (IDW) from nearest points.
DROP FUNCTION IF EXISTS refresh_map_tile(integer, integer, integer, text);
DROP FUNCTION IF EXISTS refresh_map_tile(integer, integer, integer, text, timestamptz);

CREATE OR REPLACE FUNCTION refresh_map_tile(p_z integer, p_x integer, p_y integer, p_layer text, p_as_of timestamptz DEFAULT NULL)
RETURNS bytea AS $$
DECLARE
  bbox geometry := tile_bbox_3857(p_z, p_x, p_y);
    minx double precision := ST_XMin(bbox);
    maxx double precision := ST_XMax(bbox);
    miny double precision := ST_YMin(bbox);
    maxy double precision := ST_YMax(bbox);
    px double precision := (maxx - minx) / 256.0;
    py double precision := (maxy - miny) / 256.0;
    rast raster;
    png bytea;
    minv double precision;
    maxv double precision;
    bucket_cutoff timestamptz;
    neighbor_limit integer;
    rec record;
BEGIN
    bucket_cutoff := COALESCE(p_as_of, now());
    neighbor_limit := CASE
      WHEN p_z <= 4 THEN 48
      WHEN p_z <= 7 THEN 24
      ELSE 12
    END;

    -- Gather points in the tile in WebMercator and the requested value
    CREATE TEMP TABLE tmp_points AS
    SELECT
      ST_Transform(ST_SetSRID(ST_MakePoint(longitude, latitude), 4326), 3857) AS geom,
      CASE
        WHEN p_layer = 'temperature' THEN avg_temperature
        WHEN p_layer = 'pressure' THEN avg_pressure_hpa
        WHEN p_layer = 'wind' THEN avg_wind_speed
        WHEN p_layer = 'cloud' THEN avg_cloud_cover
        WHEN p_layer = 'visibility' THEN min_visibility_km
        WHEN p_layer = 'precipitation' THEN max_precipitation_mm
        ELSE hazard_score
      END AS val
    FROM weather_tile_minute_aggregates
    WHERE bucket_start = (
      SELECT max(bucket_start)
      FROM weather_tile_minute_aggregates
      WHERE bucket_start <= bucket_cutoff
    )
      AND latitude IS NOT NULL AND longitude IS NOT NULL
      AND ST_Transform(ST_SetSRID(ST_MakePoint(longitude, latitude), 4326), 3857) && bbox;

    SELECT min(val), max(val) INTO minv, maxv FROM tmp_points;

    -- Create an empty 256x256 raster aligned to the tile bbox
    rast := ST_MakeEmptyRaster(256, 256, minx + px/2.0, maxy - py/2.0, px, -py, 0, 0, 3857);

    IF minv IS NULL THEN
        -- No data: cache empty raster and return PNG
        INSERT INTO map_raster_tiles AS m (z, x, y, layer, rast, updated_at)
        VALUES (p_z, p_x, p_y, p_layer, rast, now())
        ON CONFLICT (z, x, y, layer) DO UPDATE SET rast = EXCLUDED.rast, updated_at = EXCLUDED.updated_at;

        png := ST_AsPNG(rast);
        RETURN png;
    END IF;

    -- Compute IDW values for each pixel; store 0-255 integer into temporary table
    CREATE TEMP TABLE tmp_pixels (i integer, j integer, val integer);

    INSERT INTO tmp_pixels (i, j, val)
    SELECT i, j,
      CASE
        WHEN maxv > minv THEN
          LEAST(255, GREATEST(0, CAST(ROUND(255.0 * (coalesce(weighted.val, minv) - minv) / (maxv - minv)) AS integer)))
        ELSE 0
      END
    FROM (
      SELECT i, j,
        (
          SELECT (SUM(s.val / (s.dist + 1e-6)) / NULLIF(SUM(1.0 / (s.dist + 1e-6)), 0))
          FROM (
            SELECT p.val, ST_Distance(p.geom, ST_SetSRID(ST_MakePoint(minx + (i + 0.5) * px, maxy - (j + 0.5) * py), 3857)) AS dist
            FROM tmp_points p
            ORDER BY dist
            LIMIT neighbor_limit
          ) s
        ) AS val
      FROM generate_series(0,255) AS i CROSS JOIN generate_series(0,255) AS j
    ) AS weighted;

    -- Apply pixel values into raster
    FOR rec IN SELECT i, j, val FROM tmp_pixels LOOP
        rast := ST_SetValue(rast, 1, rec.j + 1, rec.i + 1, rec.val);
    END LOOP;

    -- Upsert into cache table
    INSERT INTO map_raster_tiles AS m (z, x, y, layer, rast, updated_at)
    VALUES (p_z, p_x, p_y, p_layer, rast, now())
    ON CONFLICT (z, x, y, layer) DO UPDATE SET rast = EXCLUDED.rast, updated_at = EXCLUDED.updated_at;

    png := ST_AsPNG(rast);
    RETURN png;
END;
$$ LANGUAGE plpgsql;
