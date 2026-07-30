#!/bin/bash
# scripts/run-backtest.sh

set -e
STRATEGY=$1
ASSET=$2

if [ -z "$STRATEGY" ] || [ -z "$ASSET" ]; then
    echo "Usage: ./scripts/run-backtest.sh <strategy_name> <asset_pair>"
    echo "Example: ./scripts/run-backtest.sh stat_arb MONAD/USDT"
    exit 1
fi

echo "Initializing GPU-accelerated backtester for $STRATEGY on $ASSET..."
source .venv/bin/activate

python3 -m apps.backtester.cli --strategy "$STRATEGY" --asset "$ASSET"

echo "Backtest complete. Results logged to data/logs/"
