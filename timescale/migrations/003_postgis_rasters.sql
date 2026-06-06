-- Enable PostGIS and add a simple cached raster tile table + refresh function
CREATE EXTENSION IF NOT EXISTS postgis;

-- Table to cache raster tiles (WebMercator, 256x256 PNG raster stored as raster)
CREATE TABLE IF NOT EXISTS map_raster_tiles (
    z integer NOT NULL,
    x integer NOT NULL,
    y integer NOT NULL,
    layer text NOT NULL,
    rast raster,
    updated_at timestamptz DEFAULT now(),
    PRIMARY KEY (z, x, y, layer)
);

-- GIST index on raster for spatial queries (if needed)
CREATE INDEX IF NOT EXISTS idx_map_raster_tiles_rast ON map_raster_tiles USING GIST (ST_ConvexHull(rast));

-- Helper: compute tile bbox in EPSG:3857 for web mercator tile z/x/y
CREATE OR REPLACE FUNCTION tile_bbox_3857(z integer, x integer, y integer)
RETURNS geometry AS $$
DECLARE
    n double precision := power(2.0, z);
    lon_left double precision := x / n * 360.0 - 180.0;
    lon_right double precision := (x + 1) / n * 360.0 - 180.0;
    lat_top_rad double precision := atan(sinh(pi() * (1 - 2.0 * y / n)));
    lat_bottom_rad double precision := atan(sinh(pi() * (1 - 2.0 * (y + 1) / n)));
    lat_top double precision := degrees(lat_top_rad);
    lat_bottom double precision := degrees(lat_bottom_rad);
    geom4326 geometry;
BEGIN
    geom4326 := ST_MakeEnvelope(lon_left, lat_bottom, lon_right, lat_top, 4326);
    RETURN ST_Transform(geom4326, 3857);
END;
$$ LANGUAGE plpgsql IMMUTABLE;

DROP FUNCTION IF EXISTS refresh_map_tile(integer, integer, integer, text);
DROP FUNCTION IF EXISTS refresh_map_tile(integer, integer, integer, text, timestamptz);
DROP FUNCTION IF EXISTS fetch_tile_png_base64(integer, integer, integer, text);
DROP FUNCTION IF EXISTS fetch_tile_png_base64(integer, integer, integer, text, timestamptz);

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
    bucket_cutoff timestamptz;
BEGIN
    bucket_cutoff := COALESCE(p_as_of, now());

    -- Make an empty raster 256x256 aligned to the tile bbox in EPSG:3857
    rast := ST_MakeEmptyRaster(256, 256, minx + px/2.0, maxy - py/2.0, px, -py, 0, 0, 3857);

    -- (Placeholder) Optionally we could burn values into rast here using ST_AsRaster/ST_SetValue

    -- Upsert into cache
    INSERT INTO map_raster_tiles AS m (z, x, y, layer, rast, updated_at)
    VALUES (p_z, p_x, p_y, p_layer, rast, now())
    ON CONFLICT (z, x, y, layer) DO UPDATE SET rast = EXCLUDED.rast, updated_at = EXCLUDED.updated_at;

    png := ST_AsPNG(rast);
    RETURN png;
END;
$$ LANGUAGE plpgsql;

-- Convenience: return base64-encoded PNG for a tile
CREATE OR REPLACE FUNCTION fetch_tile_png_base64(p_z integer, p_x integer, p_y integer, p_layer text, p_as_of timestamptz DEFAULT NULL)
RETURNS text AS $$
DECLARE
    data bytea;
BEGIN
    IF p_as_of IS NOT NULL THEN
        -- Time-sliced requests should be rendered fresh for the requested bucket.
        SELECT refresh_map_tile(p_z, p_x, p_y, p_layer, p_as_of) INTO data;
        RETURN encode(data, 'base64');
    END IF;

    SELECT t.rast INTO data
    FROM map_raster_tiles AS t
    WHERE t.z = p_z AND t.x = p_x AND t.y = p_y AND t.layer = p_layer;
    IF data IS NOT NULL THEN
        RETURN encode(ST_AsPNG(data), 'base64');
    ELSE
        -- generate on-demand and return
        SELECT refresh_map_tile(p_z, p_x, p_y, p_layer, p_as_of) INTO data;
        RETURN encode(data, 'base64');
    END IF;
END;
$$ LANGUAGE plpgsql;
