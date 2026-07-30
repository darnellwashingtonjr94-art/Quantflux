#!/bin/bash
# scripts/pin-cpu-cores.sh

set -e
echo "Isolating CPU cores for the execution engine..."

# Find the PID of the running trading engine
ENGINE_PID=$(pgrep -f "apps.trading-engine.main" || echo "")

if [ -z "$ENGINE_PID" ]; then
    echo "Trading engine is not running."
    exit 1
fi

# Pin the process to cores 4-7 on NUMA node 0
taskset -cp 4,5,6,7 "$ENGINE_PID"
echo "Process $ENGINE_PID successfully pinned to dedicated cores."
