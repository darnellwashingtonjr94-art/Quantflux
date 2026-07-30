#!/bin/bash
# scripts/deploy-model-canary.sh

set -e
MODEL_PATH=$1

if [ -z "$MODEL_PATH" ]; then
    echo "Usage: ./scripts/deploy-model-canary.sh <path_to_model.pt>"
    exit 1
fi

echo "Deploying $MODEL_PATH in Canary/Shadow Mode..."
source .venv/bin/activate

python3 -m apps.ai-engine.deploy \
    --model-path "$MODEL_PATH" \
    --mode shadow \
    --log-output ./data/logs/shadow_execution.log

echo "Model is now evaluating live data in shadow mode."
