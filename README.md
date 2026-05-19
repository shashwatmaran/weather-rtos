**Weather RTOS — Project Summary**

Overview:
- **Purpose**: A modular system for collecting, aggregating, simulating, and storing weather data with TimescaleDB integration.
- **Structure**: Small executables (collectors, aggregators, simulator, writer) reuse common protocol, publishing, and Timescale helpers found under `common/`.

How components fit together:
- **Collectors**: Produce weather messages from sensors or simulated sources and publish them to brokers.
- **Aggregators**: Subscribe to messages, run validation and aggregation, and forward results or write batches.
- **Simulator**: Generates synthetic weather traffic for testing and load experiments.
- **Timescale writer**: Consumes aggregated data (or outbox) and writes to TimescaleDB efficiently.

Key files and directories
- **`CMakeLists.txt`**: Top-level build configuration used by CMake to build all executables and link shared code.
- **`demo.sh`**: Quick demo/run helper script for local testing or demos.
- **`timescale_outbox.sql`**: SQL for an outbox/integration table related to TimescaleDB workflows.
- **`timescale/schema.sql`**: Database schema and hypertable definitions used by the Timescale writer.

- **`aggregator/`**: Region/strategy specific aggregation binaries.
  - **`aggregator/asia/main.cpp`**: Asia region aggregator entrypoint.
  - **`aggregator/india/main.cpp`**: India region aggregator entrypoint.
  - **`aggregator/hierarchical/main.cpp`**: Aggregator implementing hierarchical aggregation.

- **`collectors/`**: Data collector binaries.
  - **`collectors/regional/main.cpp`**: Regional collector implementation.
  - **`collectors/south_india/main.cpp`**: South India specific collector.

- **`simulator/main.cpp`**: Synthetic data generator for testing and load simulations.
- **`timescale_writer/main.cpp`**: Standalone writer that batches and inserts data to TimescaleDB.

- **`common/`**: Shared libraries and abstractions used by all executables.
  - **`common/models/WeatherPacket.hpp`**: Data model for sensor/weather messages.
  - **`common/protocol/MessageEnvelope.hpp`**, **`common/protocol/MessageTypes.hpp`**: Message wrapper and type definitions.
  - **`common/aggregation/BrokerAggregator.hpp`**: Aggregation logic used by aggregator binaries.
  - **`common/pipeline/ValidationAggregationConsumerPipeline.hpp`**: Pipeline combining validation and aggregation consumer stages.
  - **`common/gateway/RegionalGateway.hpp`**: Region-aware routing/gateway helper.
  - **`common/publishing/BrokerPublisher.hpp`**: Publisher interface/implementation for sending messages.
  - **`common/subscribing/`**: Publisher/subscriber interfaces and concrete implementations (in-process, TCP).
  - **`common/socket/TCPSocket.hpp`**, **`common/socket/TCPSocket.cpp`**: Lightweight TCP helpers.
  - **`common/timescale/`**: `AsyncQueueWriter.hpp`, `TimescaleBatchWriter.hpp`, `TimescaleDbClient.hpp` — batching and DB client utilities for TimescaleDB.
  - **`common/utils/RuntimeConfig.hpp`**: Runtime configuration loader and helpers.

- **`configs/`**: JSON configuration and topology files.
  - **`configs/global_topology.json`**: Global node and routing topology.
  - **`configs/south_india.json`**: Region-specific configuration used by the South India collector/aggregator.

- **`docs/`**: Documentation.
  - **`docs/ARCHITECTURE.md`**: System architecture and component interactions.
  - **`docs/QUICKSTART.md`**: How to build and run locally.
  - **`docs/SCALING.md`**: Notes on scaling, partitioning, and performance tuning.

- **`build/`**: Generated CMake build artifacts and compiled binaries — ignore for source changes (contains targets like `asia_aggregator`, `regional_collector`, `simulator`, `timescale_writer`).

Runtime notes:
- The system supports both in-process and TCP-based messaging using the publisher/subscriber abstractions.
- Aggregators validate and reduce incoming `WeatherPacket` data, then either forward results or write to an outbox consumed by the `timescale_writer`.
- `simulator` simplifies local testing by producing realistic traffic matching the `WeatherPacket` schema.

Next steps you might want:
- Add this `README.md` to the repo root (created).
- Ask for a deep-dive on any file (I can open and explain line-by-line).
- Generate quick run commands or a developer `Makefile` snippet for local testing.
