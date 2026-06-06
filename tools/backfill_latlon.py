#!/usr/bin/env python3
import argparse
import json
import os
import sys

try:
    import psycopg2
except Exception:
    psycopg2 = None

def load_topology(path):
    with open(path, 'r', encoding='utf-8') as f:
        topology = json.load(f)
    mapping = {}
    for region in topology.get('topology', {}).get('regions', []):
        region_name = region.get('name')
        for city in region.get('cities', []):
            name = city.get('name')
            lat = city.get('latitude')
            lon = city.get('longitude')
            if name and lat is not None and lon is not None:
                mapping[f"{region_name}:{name}"] = (lat, lon)
                mapping[name] = (lat, lon)
    return mapping

def main():
    parser = argparse.ArgumentParser(description='Backfill NULL latitude/longitude in weather_tile_minute_aggregates from topology')
    parser.add_argument('--topology', default='configs/global_topology.json')
    parser.add_argument('--dsn', default=os.environ.get('TIMESCALEDB_DSN'))
    parser.add_argument('--dry-run', action='store_true')
    args = parser.parse_args()

    if psycopg2 is None:
        print('psycopg2 is required: pip install psycopg2-binary')
        sys.exit(1)

    mapping = load_topology(args.topology)
    if not mapping:
        print('No topology mapping found')
        sys.exit(1)

    if not args.dsn:
        print('Provide DSN via --dsn or TIMESCALEDB_DSN env var')
        sys.exit(1)

    conn = psycopg2.connect(args.dsn)
    cur = conn.cursor()
    cur.execute("SELECT DISTINCT tile_id FROM weather_tile_minute_aggregates WHERE latitude IS NULL OR longitude IS NULL;")
    rows = cur.fetchall()
    updates = 0
    for (tile_id,) in rows:
        if not tile_id:
            continue
        if ':' in tile_id:
            key = tile_id
        else:
            key = tile_id
        coords = mapping.get(key)
        if coords:
            lat, lon = coords
            print(f'Will set {tile_id} -> {lat},{lon}')
            if not args.dry_run:
                cur.execute("UPDATE weather_tile_minute_aggregates SET latitude = %s, longitude = %s WHERE tile_id = %s AND (latitude IS NULL OR longitude IS NULL);", (lat, lon, tile_id))
                updates += cur.rowcount

    if not args.dry_run:
        conn.commit()
    cur.close()
    conn.close()
    print(f'Done. Updated rows: {updates}')

if __name__ == '__main__':
    main()
