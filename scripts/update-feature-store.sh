#!/bin/bash
# scripts/update-feature-store.sh

set -e
echo "Updating AI feature store with latest market data..."
source .venv/bin/activate

python3 -m apps.ai-engine.feature_pipeline \
    --input-dir ./data/market/ \
    --output-dir ./data/models/features/ \
    --timeframes "1m,5m,1h"

echo "Feature store successfully updated."
