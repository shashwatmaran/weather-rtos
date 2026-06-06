#!/usr/bin/env python3
import argparse
import math
import os
import sys
import time
from urllib.parse import urljoin
import urllib.request
import urllib.error

def deg2num(lat_deg, lon_deg, zoom):
    lat_rad = math.radians(lat_deg)
    n = 2.0 ** zoom
    xtile = int((lon_deg + 180.0) / 360.0 * n)
    ytile = int((1.0 - math.log(math.tan(lat_rad) + 1 / math.cos(lat_rad)) / math.pi) / 2.0 * n)
    return xtile, ytile

def clamp(v, a, b):
    return max(a, min(b, v))

def main():
    parser = argparse.ArgumentParser(description='Warm map tile PNG cache by requesting tiles from map_query_api')
    parser.add_argument('--api', default=os.environ.get('API_BASE', 'http://127.0.0.1:8091'), help='API base URL')
    parser.add_argument('--min-lon', type=float, required=True)
    parser.add_argument('--min-lat', type=float, required=True)
    parser.add_argument('--max-lon', type=float, required=True)
    parser.add_argument('--max-lat', type=float, required=True)
    parser.add_argument('--min-z', type=int, default=5)
    parser.add_argument('--max-z', type=int, default=7)
    parser.add_argument('--layer', default='hazard')
    parser.add_argument('--delay', type=float, default=0.02, help='Seconds to sleep between requests')
    args = parser.parse_args()

    api = args.api.rstrip('/')
    total = 0
    for z in range(args.min_z, args.max_z + 1):
        x1, y1 = deg2num(args.max_lat, args.min_lon, z)
        x2, y2 = deg2num(args.min_lat, args.max_lon, z)

        xmin = min(x1, x2)
        xmax = max(x1, x2)
        ymin = min(y1, y2)
        ymax = max(y1, y2)

        xmin = clamp(xmin, 0, 2 ** z - 1)
        xmax = clamp(xmax, 0, 2 ** z - 1)
        ymin = clamp(ymin, 0, 2 ** z - 1)
        ymax = clamp(ymax, 0, 2 ** z - 1)

        print(f'Warm z={z} x={xmin}-{xmax} y={ymin}-{ymax}')
        for x in range(xmin, xmax + 1):
            for y in range(ymin, ymax + 1):
                url = f"{api}/v1/map/tiles/png/{z}/{x}/{y}?layer={args.layer}"
                try:
                    req = urllib.request.Request(url, headers={"User-Agent": "warm-tiles/1.0"})
                    with urllib.request.urlopen(req, timeout=10) as resp:
                        code = resp.getcode()
                        if code == 200:
                            total += 1
                        else:
                            print(f'WARN {code} {url}')
                except urllib.error.HTTPError as e:
                    print('WARN', e.code, url)
                except Exception as e:
                    print('ERR', e)
                time.sleep(args.delay)

    print(f'Completed requests: {total}')

if __name__ == '__main__':
    main()
