#!/bin/bash
# scripts/twap-accumulate.sh

set -e
ASSET=${1:-"MONAD"}
TOTAL_USD=${2:-"50000"}

# Enforced fiat bounds for the execution zone
MIN_USD_TARGET=0.30
MAX_USD_TARGET=1.00

echo "Executing TWAP accumulation for $ASSET."
echo "Target accumulation zone locked strictly between \$$MIN_USD_TARGET and \$$MAX_USD_TARGET."

source .venv/bin/activate
python3 -m apps.trading-engine.strategies.twap_accumulation \
    --asset "$ASSET" \
    --total-size "$TOTAL_USD" \
    --min-usd "$MIN_USD_TARGET" \
    --max-usd "$MAX_USD_TARGET"
