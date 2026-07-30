#!/bin/bash
# scripts/rebalance-margin.sh

set -e
echo "Initiating cross-venue margin rebalancing..."
source .venv/bin/activate

python3 -m apps.risk-engine.rebalancer \
    --config infra/wallets.json \
    --min-margin-usd 10000 \
    --dry-run false

echo "Margin rebalancing operations dispatched successfully."
