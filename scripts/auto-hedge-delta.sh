#!/bin/bash
# scripts/auto-hedge-delta.sh

set -e
TOLERANCE=${1:-"0.15"} # Allowable delta drift (15%)

echo "Activating Auto-Delta Hedger with a $TOLERANCE drift tolerance..."
source .venv/bin/activate

python3 -m apps.risk-engine.delta_hedger \
    --tolerance "$TOLERANCE" \
    --hedge-instrument "BTC-PERP" \
    --execution-venue "binance"

echo "Delta hedging module is monitoring portfolio exposure."
