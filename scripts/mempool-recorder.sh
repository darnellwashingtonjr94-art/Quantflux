#!/bin/bash
# scripts/mempool-recorder.sh

set -e
WS_ENDPOINT=${1:-"ws://localhost:8546"}
OUTPUT_DIR="data/market/mempool_dumps"

mkdir -p "$OUTPUT_DIR"
echo "Recording mempool state from $WS_ENDPOINT..."
source .venv/bin/activate

python3 -m libs.data.mempool_streamer \
    --endpoint "$WS_ENDPOINT" \
    --output "$OUTPUT_DIR" \
    --rotation-interval 3600 # Rotate files every hour

echo "Mempool stream terminated."
