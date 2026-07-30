#!/bin/bash
# scripts/multi-model-sentiment.sh

set -e
ASSET=${1:-"BTC"}
echo "Orchestrating multi-model AI sentiment analysis for $ASSET..."
source .venv/bin/activate

python3 -m apps.ai-engine.orchestrator \
    --asset "$ASSET" \
    --models "gemini,claude,chatgpt,grok" \
    --output-feature-store ./data/models/features/sentiment.parquet

echo "Multi-model synthesis complete. Sentiment vectors updated."
