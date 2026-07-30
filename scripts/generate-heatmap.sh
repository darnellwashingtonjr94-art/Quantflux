#!/bin/bash
# scripts/generate-heatmap.sh

set -e
ASSET=${1:-"BTC/USDT"}
DATE=${2:-$(date +"%Y-%m-%d")}

echo "Generating L2 Orderbook Heatmap for $ASSET on $DATE..."
source .venv/bin/activate

python3 -m libs.analytics.orderbook_heatmap \
    --asset "$ASSET" \
    --date "$DATE" \
    --depth 50 \
    --output "./docs/product/reports/heatmap_$DATE.html"

echo "Heatmap generated at ./docs/product/reports/heatmap_$DATE.html"
