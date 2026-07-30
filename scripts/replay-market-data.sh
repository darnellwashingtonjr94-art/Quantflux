#!/bin/bash
# scripts/replay-market-data.sh

set -e
ASSET=${1:-"MONAD/USDT"}
DATE=${2:-"2023-10-01"}
SPEED=${3:-"1x"}

echo "Initializing market data replay for $ASSET from $DATE at ${SPEED} speed..."
source .venv/bin/activate

python3 -m libs.data.replay_engine \
    --asset "$ASSET" \
    --start-date "$DATE" \
    --speed "$SPEED" \
    --output-bus "kafka://localhost:9092"

echo "Data replay finished."
