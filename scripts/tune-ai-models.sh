#!/bin/bash
# scripts/tune-ai-models.sh

set -e
STRATEGY=${1:-"hmm_regime"}
TRIALS=${2:-100}

echo "Initiating hyperparameter optimization for $STRATEGY ($TRIALS trials)..."
source .venv/bin/activate

python3 -m apps.ai-engine.optimize \
    --model "$STRATEGY" \
    --trials "$TRIALS" \
    --n-jobs -1 # Use all available CPU cores

echo "Optimization complete. Best parameters saved to data/models/params.json"
