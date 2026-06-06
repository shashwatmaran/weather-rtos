# Logistics Map Architecture and Phase 1 Implementation Plan

This plan adapts the current Weather RTOS architecture into a map-first logistics intelligence platform.

Primary product goal:
- project weather risk on a map
- score route segments by operational risk
- estimate delay impact for transport routes

## 1. Target Architecture (Ideal for This Repo)

The best fit for the current codebase is an event-driven, region-partitioned architecture with a read-optimized query layer.

Pipeline:
- Region collectors (collector = region)
- Hierarchical analytics aggregators
- Timescale writer
- Map query API
- Web map client

Data flow:
1. Region collector emits normalized weather envelopes tagged with region and geolocation.
2. Regional analytics aggregator computes tile-level hazard metrics.
3. Higher-tier aggregator computes corridor/route risk and delay signals.
4. Writer persists raw + aggregate + route-risk records.
5. Query API returns tile overlays and route risk summaries to map UI.

Why this is ideal:
- preserves existing collector/aggregator/writer architecture
- scales horizontally by region key
- keeps write path append-oriented and query path pre-aggregated
- enables low-latency map rendering without scanning raw events

## 2. Collector-As-Region Topology

Interpretation rule for this project:
- one collector instance owns one region partition
- each collector can still ingest many cities/stations inside that region

Recommended region granularity for Phase 1:
- metro-scale regions for dense operations
- corridor-scale regions for highway/freight focus
- avoid oversized regions that create hot partitions

Suggested topology shape:
- `collector.region.<region_id>` -> `agg.tile.<continent|country>` -> `agg.route.global` -> `writer.timescale`

Notes:
- Keep one topic key per `region`.
- Ensure envelopes include consistent `region`, `city`, and coordinates.
- Keep region key stable over time to preserve partition locality.

## 3. Phase 1 Scope

Phase 1 outcome:
- live weather risk map
- route risk score (not full route optimization)
- first ETA impact estimate

In scope:
- tile-level overlays for wind, rain proxy, heat, humidity, and combined hazard
- route-level risk score and delay factor
- API endpoints for map layer and route evaluation
- baseline alert rules for severe conditions

Out of scope for Phase 1:
- full fleet dispatch optimizer
- ML-heavy long-horizon forecasting
- dynamic traffic integration from external paid feeds

## 4. Data Model Changes (Phase 1)

Extend payload model beyond basic weather fields.

### 4.1 Envelope payload additions

Add fields to payload JSON (can be optional initially):
- `latitude`
- `longitude`
- `visibility_km`
- `precipitation_mm`
- `pressure_hpa`
- `station_id`

Keep backward compatibility:
- if fields are missing, compute only partial hazard score

### 4.2 New aggregate tables (recommended)

Add Timescale tables:
- `weather_tile_minute_aggregates`
- `route_segment_risk_minute`

`weather_tile_minute_aggregates` columns:
- `bucket_start`
- `tile_id`
- `continent`
- `country`
- `region`
- `sample_count`
- `avg_temperature`
- `avg_humidity`
- `avg_wind_speed`
- `min_visibility_km`
- `max_precipitation_mm`
- `hazard_score`

`route_segment_risk_minute` columns:
- `bucket_start`
- `route_id`
- `segment_id`
- `region`
- `hazard_score`
- `delay_factor`
- `primary_hazard`

## 5. Analytics Definitions

Phase 1 formulas should be deterministic and easy to explain.

### 5.1 Tile hazard score

Use weighted normalized metrics:

$$hazard = 0.35 * wind_{norm} + 0.30 * precip_{norm} + 0.20 * vis_{norm} + 0.15 * heat_{norm}$$

Where:
- `wind_norm` increases near wind danger threshold
- `precip_norm` increases with precipitation intensity
- `vis_norm` increases as visibility decreases
- `heat_norm` increases outside comfortable operating band

Clamp score to `[0, 100]`.

### 5.2 Route segment delay factor

For each segment:

$$delay\_factor = 1.0 + 0.004 * hazard + 0.002 * crosswind\_norm$$

Estimated segment travel time:

$$eta\_segment = baseline\_eta * delay\_factor$$

Route ETA is sum of segment ETAs.

## 6. API Design for Map Experience

### 6.1 Tile overlay endpoint

`GET /v1/map/tiles`

Query params:
- `bbox`
- `zoom`
- `at` (timestamp)
- `layer` (`hazard|wind|visibility|precipitation`)

Returns:
- tile geometries or tile IDs
- layer value
- color class
- freshness timestamp

### 6.2 Route risk endpoint

`POST /v1/routes/risk`

Input:
- ordered route polyline or segment IDs
- optional departure timestamp

Returns:
- per-segment hazard score
- primary hazard type
- delay factor
- route-level risk summary
- projected ETA delta

### 6.3 Alert snapshot endpoint

`GET /v1/alerts/active?region=<id>`

Returns active severe hazards for map badges and ops panels.

## 7. Component-by-Component Implementation

## 7.1 Collector changes

Target files:
- `collectors/regional/main.cpp`
- `common/models/WeatherPacket.hpp`

Tasks:
- treat each collector instance as one region owner
- add optional geospatial/weather severity fields to packet payload
- enforce stable `region` tag on every message

## 7.2 Aggregator changes

Target files:
- `aggregator/hierarchical/main.cpp`
- `common/pipeline/ValidationAggregationConsumerPipeline.hpp`

Tasks:
- add tile bucketing logic (for example geohash/H3 tile id)
- compute hazard score per tile window
- emit route-segment risk events for downstream writer

## 7.3 Writer changes

Target files:
- `common/timescale/TimescaleBatchWriter.hpp`
- `timescale/schema.sql`

Tasks:
- persist new tile and route risk aggregates in same flush cycle
- add conflict upsert semantics for minute buckets
- keep raw table as immutable source of truth

## 7.4 Query API (new service)

Create a small service:
- `services/map_query_api/` (new)

Responsibilities:
- read from aggregate tables only
- support bbox/timestamp queries
- support route-risk computation over latest aggregates

## 7.5 Map UI (new service)

Create frontend:
- `apps/map_console/` (new)

Responsibilities:
- render base map
- overlay hazard layer colors
- show route segment risk with legend
- expose time slider for playback

## 8. Phase 1 Rollout Plan

Week 1:
- topology/config update for collector-as-region
- payload schema extension
- migration SQL for new aggregate tables

Week 2:
- tile aggregation + hazard score in aggregator pipeline
- writer support for new aggregates

Week 3:
- map query API for tile overlays + route risk endpoint
- smoke tests against simulator traffic

Week 4:
- basic map UI with overlay and route panel
- alert badges and severity legend
- performance and correctness validation

## 9. SLOs and Success Criteria

Operational SLO targets for Phase 1:
- ingest to map availability p95 < 10s
- route risk API p95 < 300ms for 100-segment route
- aggregate freshness lag < 60s for active regions
- no message loss during normal load test bursts

Business success criteria:
- route-level risk visible on map in real time
- ETA delta estimates generated for requested routes
- dispatch team can identify high-risk corridors in under 30 seconds

## 10. Validation and Testing

Use simulator load to validate:
- hazard score stability under burst traffic
- idempotent upserts for aggregate buckets
- route risk reproducibility for identical input/time
- API correctness against known synthetic scenarios

Minimum test set:
- unit tests for hazard and delay formulas
- integration tests for collector -> aggregator -> writer chain
- API contract tests for map and route endpoints
- one end-to-end replay test with incident scenario

## 11. Risks and Mitigations

Risk: inconsistent region labels from collectors
- Mitigation: strict validation and normalization in pipeline.

Risk: aggregate skew from late-arriving events
- Mitigation: allow bounded late data window and recompute bucket updates.

Risk: route-risk endpoint too slow at high segment counts
- Mitigation: precompute segment-level snapshots and cache hot routes.

Risk: map layer overload at high zoom levels
- Mitigation: serve pre-bucketed tiles and enforce zoom-aware query limits.

## 12. Decisions Locked for Phase 1

- Collector is the region ownership boundary.
- Region key is the partition key across ingestion, aggregation, and storage.
- Tile and route aggregates are first-class persisted products.
- Map and route APIs read pre-aggregated tables, not raw events.
- Keep formulas deterministic before adding ML.
