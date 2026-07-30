#!/bin/bash
# scripts/snapshot-engine-state.sh

set -e
echo "Forcing memory snapshot of the execution engine..."
source .venv/bin/activate

# Triggers an internal gRPC call to serialize state to Redis
python3 -m apps.api.admin_client trigger-snapshot --target "trading-engine" --destination "redis://localhost:6379/1"

echo "RAM state successfully snapshotted."
