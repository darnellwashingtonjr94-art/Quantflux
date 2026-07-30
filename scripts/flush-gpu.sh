#!/bin/bash
# scripts/flush-gpu.sh

set -e
echo "Scanning for orphaned GPU processes..."

# Find PIDs using NVIDIA GPUs
PIDS=$(nvidia-smi --query-compute-apps=pid --format=csv,noheader)

if [ -z "$PIDS" ]; then
    echo "No orphaned processes found. GPU memory is clear."
else
    echo "Killing the following Python/CUDA processes: $PIDS"
    for pid in $PIDS; do
        sudo kill -9 "$pid"
    done
    echo "GPU VRAM successfully flushed."
fi
