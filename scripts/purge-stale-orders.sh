#!/bin/bash
# scripts/purge-stale-orders.sh

set -e
echo "Scanning for and purging stale ghost orders across all venues..."
source .venv/bin/activate

python3 -m apps.trading-engine.order_manager \
    --action "cancel_untracked" \
    --older-than-mins 5 \
    --venues "binance,bybit,okx"

echo "Order books synchronized. Untracked orders cancelled."
