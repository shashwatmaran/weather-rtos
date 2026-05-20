# Architecture & Design Overview

This document summarizes the functional components, core concepts, concurrency model, logging, and operational notes for the Weather RTOS repository.

**Purpose**
- Provide a clear mental model for how components communicate and run in the existing hierarchy (collectors → regional aggregators → continent aggregators → global aggregator → timescale writer).
- Explain threading, synchronization, and logging decisions so maintainers can safely modify or extend the system.

**High-level components**
- Collectors: read sensor/source data per city and publish messages into the system. The primary path is [collectors/regional/main.cpp](collectors/regional/main.cpp).
- Regional Aggregators: ingest region-level events and forward/aggregate them. The primary path is [aggregator/hierarchical/main.cpp](aggregator/hierarchical/main.cpp).
- Continent Aggregators: aggregate regional outputs for a continent and forward them upward.
- Global Aggregator: receives continent aggregates and performs final consolidation.
- Timescale Writer: persists aggregated data into TimescaleDB. See [timescale_writer/main.cpp](timescale_writer/main.cpp) and [common/timescale/AsyncQueueWriter.hpp](common/timescale/AsyncQueueWriter.hpp).
- In-process Broker: a lightweight publish/subscribe implementation used for process-local messaging. See [common/subscribing/InProcessBrokerSubscriber.hpp](common/subscribing/InProcessBrokerSubscriber.hpp) and related publisher interfaces.
- TCP Gateway / Subscribers: optional network transport for inter-process message passing. See [common/gateway/RegionalGateway.hpp](common/gateway/RegionalGateway.hpp) and [common/subscribing/TcpSubscriber.hpp](common/subscribing/TcpSubscriber.hpp).

**Message model and types**
- MessageEnvelope: canonical envelope used across components; sequence numbers are atomic for concurrency. See [common/protocol/MessageEnvelope.hpp](common/protocol/MessageEnvelope.hpp).
- WeatherPacket: payload format for sensor events; converters and validation are in `common/models` and `common/pipeline`.

**Pipeline and validation**
- `ValidationAggregationConsumerPipeline` (see [common/pipeline/ValidationAggregationConsumerPipeline.hpp](common/pipeline/ValidationAggregationConsumerPipeline.hpp)) performs:
  - Packet deserialization from MessageEnvelope.
  - Validation checks (range checks and required fields).
  - Recording counts/statistics (protected by an internal mutex).
  - Logging the raw envelope (now written into the `logs/` directory).
  - Optional `onSuccess` callback for downstream actions.

**Concurrency & threading model**
- Design principle: components are composed from a small set of concurrency patterns:
  1. One OS process per component instance (launched by `demo.sh`).
  2. Within a process, a small number of dedicated threads handle I/O versus processing.

- Common patterns used across the codebase:
  - Per-city poll threads (Collectors) — each city has a polling thread that samples/generates events and enqueues them. See [collectors/regional/main.cpp](collectors/regional/main.cpp).
  - Sender thread (Collectors) — a dedicated thread dequeues and publishes messages (non-blocking submit pattern protected by `queueMutex`).
  - TCP adapter thread(s) (Aggregators) — accept connections and spawn per-client receiver threads. See [aggregator/hierarchical/main.cpp](aggregator/hierarchical/main.cpp) and [common/gateway/RegionalGateway.hpp](common/gateway/RegionalGateway.hpp).
  - Broker consumer threads — the in-process broker subscriber runs a loop and hands messages to the pipeline. Implementations follow the `IBrokerSubscriber` interface (see [common/subscribing/IBrokerSubscriber.hpp](common/subscribing/IBrokerSubscriber.hpp)).
  - Timescale writer: subscriber thread that receives messages and a writer/main thread responsible for batching and flushing (see [timescale_writer/main.cpp](timescale_writer/main.cpp) and [common/timescale/AsyncQueueWriter.hpp](common/timescale/AsyncQueueWriter.hpp)).

- Synchronization primitives:
  - `std::mutex` and `std::lock_guard` / `std::unique_lock` for protecting shared queues and counters (e.g., `queueMutex` in collectors, `queueMutex_` in AsyncQueueWriter, `mutex_` in ValidationAggregationConsumerPipeline).
  - `std::atomic<bool>` used as a running flag for shutdown coordination across threads.
  - `std::atomic` counters for lightweight statistics and sequence numbers (see [common/protocol/MessageEnvelope.hpp](common/protocol/MessageEnvelope.hpp)).

- Shutdown pattern: most processes use an atomic `running` flag, worker threads periodically check it and join on shutdown (clean join semantics across created threads).

**I/O and blocking behavior**
- Networking and socket reads are typically handled on dedicated threads so blocking I/O doesn't stall the main processing loops. The gateway/subscriber implementations spawn receive threads per client.
- Disk writes (logging) are append-only; the timescale writer batches database writes to amortize latency.

**Logging strategy**
- Demo runner redirects component stdout/stderr into per-component logs under `logs/` by default. See [demo.sh](demo.sh).
- Consumer pipeline logs per-consumer envelopes into `logs/<consumer>.log` (see [common/pipeline/ValidationAggregationConsumerPipeline.hpp](common/pipeline/ValidationAggregationConsumerPipeline.hpp)).
- Rotation: a small rotation script `logs/rotate.sh` is provided to compress rotated logs and keep a fixed retention (`logs/rotate.sh`). The directory contains a `.gitignore` so logs aren't committed.

**Build & run**
- Build with CMake (project uses standard CMake files in the repo root). Typical flow:
```bash
mkdir -p build && cd build
cmake ..
cmake --build . -j 4
```
- Run demo: from repo root:
```bash
./demo.sh
```
- Environment variables:
  - `TIMESCALEDB_DSN` — DSN for TimescaleDB (default provided in `demo.sh`).
  - `WEATHER_RTOS_HOST` — network host used by some components.
  - `LOGDIR` — override location for logs; otherwise `logs/` in repo root is used.

**Operational recommendations & notes**
- For production-like deployments prefer structured logging and shipping to a log collector (stdout → journald/Fluentd) rather than per-file logs in the repo.
- Consider replacing custom rotation with the platform `logrotate` or a `systemd` journal if you run long-lived services.
- Thread-safety: avoid holding locks while performing blocking I/O or heavy CPU work; prefer queue handoff and worker threads for I/O.
- For scaling writers to TimescaleDB, consider sharding by region and multiple writer threads or processes (AsyncQueueWriter already exposes batching and counters to tune).

**Where to look in the codebase**
- Demo & orchestration: [demo.sh](demo.sh)
- Logging rotation: [logs/rotate.sh](logs/rotate.sh)
- Consumer pipeline: [common/pipeline/ValidationAggregationConsumerPipeline.hpp](common/pipeline/ValidationAggregationConsumerPipeline.hpp)
- In-process broker: [common/subscribing/InProcessBrokerSubscriber.hpp](common/subscribing/InProcessBrokerSubscriber.hpp)
- TCP subscriber & gateway: [common/subscribing/TcpSubscriber.hpp](common/subscribing/TcpSubscriber.hpp), [common/gateway/RegionalGateway.hpp](common/gateway/RegionalGateway.hpp)
- Timescale writer and batching: [timescale_writer/main.cpp](timescale_writer/main.cpp), [common/timescale/AsyncQueueWriter.hpp](common/timescale/AsyncQueueWriter.hpp), [common/timescale/TimescaleBatchWriter.hpp](common/timescale/TimescaleBatchWriter.hpp)

If you'd like, I can:
- Add a `docs/QUICKSTART.md` with exact build/run steps and example commands
- Replace per-consumer log files with structured JSON logs to stdout for easier ingestion
- Create a `logrotate` config for system integration

---
Last updated: May 19, 2026
