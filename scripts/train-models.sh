#!/bin/bash
# scripts/train-models.sh

set -e
MODEL_TYPE=${1:-"hmm_regime"}

echo "Starting model training pipeline for: $MODEL_TYPE"
source .venv/bin/activate

python3 -m apps.ai-engine.train --model "$MODEL_TYPE" --data-dir ./data/market/ --output-dir ./data/models/

echo "Training complete. Weights serialized to data/models/"
