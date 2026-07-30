#!/bin/bash
# scripts/benchmark-rpcs.sh

set -e
echo "Benchmarking EVM and SVM RPC node latency..."
source .venv/bin/activate

python3 -m libs.shared.rpc_benchmarker \
    --config ./infra/rpc_endpoints.json \
    --output-env ./.env.rpc.tmp

echo "Benchmarking complete. Recommended endpoints saved to .env.rpc.tmp"
