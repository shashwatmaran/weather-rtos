# Standalone Runtime Guide

This repo already supports a fully standalone second-laptop runtime.
The second machine runs the whole topology locally, so it does not need to talk to this laptop unless you later decide to split the stack across machines.

## What the second laptop needs

- Linux or another Unix-like system with Bash
- A C++20 toolchain
- CMake
- `make`
- `libcurl` development headers and library
- The headers already used in the repo, including `nlohmann/json`
- Network access to `api.open-meteo.com` for live weather fetches
- Permission to bind the TCP ports used by the stack

## What you do not need yet

- A TimescaleDB server
- Any remote broker or message bus
- Any connection back to the primary development laptop

The current Timescale stage writes to `timescale_outbox.sql`, so the runtime is self-contained for now.

If you do want the writer to talk to a real TimescaleDB instance, set `TIMESCALEDB_DSN` or `TIMESCALEDB_CONNECTION_STRING` before starting `timescale_writer`.
The writer will then execute the same batch SQL directly against the database and keep the outbox as a fallback.

Example:

```bash
export TIMESCALEDB_DSN="host=127.0.0.1 port=5432 dbname=weather_rtos user=postgres password=secret"
```

Load the schema once with `timescale/schema.sql` on that database.
It creates the hypertables and indexes used by the writer.

## Standalone run steps

1. Clone or copy the repository to the second laptop.
2. Install the native dependencies.
3. Build the binaries:

   ```bash
   cmake -S . -B build
   cmake --build build -j 4
   ```

4. Run the full local stack:

   ```bash
   ./demo.sh
   ```

Keep `WEATHER_RTOS_HOST` unset, or leave it at the default `127.0.0.1`, for a fully standalone run on that machine.

## If you later split the stack across machines

The TCP publishers honor `WEATHER_RTOS_HOST`.
Set it to the IP address of the machine hosting the TCP listeners:

```bash
export WEATHER_RTOS_HOST=<other-laptop-ip>
```

Then start the binaries or `./demo.sh` on the machine that is running the listeners.

## Ports used by the current topology

Make sure these ports are free on the laptop that is running the stack:

- `9101` for the India regional gateway
- `9201` for the Asia consumer TCP adapter
- `10101`, `10102`, `10103` for regional aggregators
- `11101`, `11102`, `11103` for continent aggregators
- `12101` for the global aggregator
- `13101` for the Timescale writer

If a firewall is enabled, allow inbound TCP traffic on those ports.

## Recommended setup

Use this laptop for primary development and the second laptop as the always-on runtime machine.
That keeps your dev environment clean while giving you a reproducible place to run the full stack locally.
