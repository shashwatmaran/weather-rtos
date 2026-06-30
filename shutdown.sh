#!/bin/bash
echo "Initiating graceful shutdown..."

# SIGTERM allows C++ apps to catch the signal and cleanly close database 
# connections, flush remaining queue items, and exit cleanly.

if [ -f simulator.pid ]; then
  echo "Stopping simulator..."
  kill -SIGTERM $(cat simulator.pid) 2>/dev/null || true
  rm simulator.pid
fi

if [ -f writer.pid ]; then
  echo "Stopping timescale_writer (Waiting for queue to flush)..."
  kill -SIGTERM $(cat writer.pid) 2>/dev/null || true
  rm writer.pid
fi

if [ -f api.pid ]; then
  echo "Stopping map_query_api..."
  kill -SIGTERM $(cat api.pid) 2>/dev/null || true
  rm api.pid
fi

if [ -f dashboard.pid ]; then
  echo "Stopping dashboard..."
  kill -SIGTERM $(cat dashboard.pid) 2>/dev/null || true
  rm dashboard.pid
fi

# Fallback in case they were started manually without PID files
echo "Ensuring all stray instances are terminated..."
pkill -SIGTERM -f map_query_api || true
pkill -SIGTERM -f timescale_writer || true
pkill -SIGTERM -f simulator || true
pkill -SIGTERM -f "http.server 5174" || true

echo "Shutdown complete."
