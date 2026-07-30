#!/bin/bash
# scripts/train-rl-agent.sh

set -e
ENV_NAME=${1:-"OrderBookEnv-v0"}
TIMESTEPS=${2:-1000000}

echo "Training RL Agent on environment $ENV_NAME for $TIMESTEPS timesteps..."
source .venv/bin/activate

python3 -m apps.ai-engine.rl_trainer \
    --env "$ENV_NAME" \
    --timesteps "$TIMESTEPS" \
    --algo "PPO" \
    --save-path ./data/models/rl_agent_latest.zip

echo "RL Agent training complete and model exported."
