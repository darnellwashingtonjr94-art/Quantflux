#!/bin/bash
# scripts/eval-ai-models.sh

set -e
MODEL_NAME=${1:-"hmm_regime"}

echo "Evaluating AI model: $MODEL_NAME on out-of-sample datasets..."
source .venv/bin/activate

python3 -m apps.ai-engine.evaluate --model "$MODEL_NAME" --test-data ./data/market/test_set.parquet

echo "Evaluation complete. Metrics exported to data/logs/model_metrics.json"
