# Scaling and Operational Guidance

This document outlines approaches to scale the Weather RTOS system from a local demo to larger deployments.

1) Observability and metrics
- Export metrics from writers/aggregators (counters in `AsyncQueueWriter` are a start: processed, errors, queue depth). Collect via Prometheus exporters.
- Centralize logs: prefer structured logs to stdout and a collector (journald/Fluentd/JSON -> ELK) rather than many local files.

2) Logging & rotation
- For long-lived services, use journald or a log forwarder. If file logs are required, use `logrotate` or `logs/rotate.sh` and store on separate volume.

3) Horizontal scaling patterns
- Separate concerns: run collectors, aggregators, continent/global aggregators, and writers as independent services (can be containers).
- Use a durable broker (NATS/Redis/Kafka) for high-throughput decoupling between producers and consumers. The in-process broker is fine for single-host testing only.
- Partition topics by region/continent so multiple consumers can scale without hot-keys.

4) TimescaleDB scaling
- Use hypertables partitioned by time and a region tag for efficient writes and queries.
- Batch inserts: tune batch size and flush interval in `AsyncQueueWriter`/`TimescaleBatchWriter` to trade latency vs throughput.
- Use connection pooling and multiple writer workers if single-writer throughput becomes a bottleneck. Consider sharding writes by region to multiple DB instances if necessary.

5) Backpressure and reliability
- Implement backpressure when queues grow: rate-limit collectors or return failures from publish APIs. `AsyncQueueWriter` exposes `backpressureEvents` count — use it to trigger autoscaling.
- Persist critical messages to a durable queue (Kafka or persisted Redis streams) to avoid loss under load.

6) Resource sizing and deployment
- Start with 2–4 vCPU and 4–8 GB RAM per aggregator for modest loads; scale up based on observed metrics.
- Run the TimescaleDB on dedicated IO-optimized instances; tune `shared_buffers`, WAL settings, and connection limits.

7) High availability
- Run multiple instances of each aggregator behind a load balancer or via the broker with consumer groups.
- Use leader-election only where a single active instance is required (e.g., for jobs that must run once).

8) Testing and load generation
- Use the `simulator/` binary to generate load and validate throughput.
- Add stress tests that exercise large message bursts and validate no data loss and stable queue depths.

9) Security & production hardening
- Secure network endpoints with mTLS or VPNs.
- Limit filesystem permissions for logs and config files; rotate secrets and avoid embedding credentials in code.

10) Next actionable improvements
- Add structured JSON logging and environment-driven log level.
- Add Prometheus metrics and a Grafana dashboard for key signals (queue depth, batch flush latency, write errors).
- Replace the in-process broker with a production broker for durability and horizontal scaling.
