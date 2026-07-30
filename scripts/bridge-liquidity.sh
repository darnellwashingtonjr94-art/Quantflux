#!/bin/bash
# scripts/bridge-liquidity.sh

set -e
AMOUNT_USDC=${1:-"10000"}
SOURCE=${2:-"arbitrum"}
DESTINATION=${3:-"monad"}

echo "Bridging $AMOUNT_USDC USDC from $SOURCE to $DESTINATION..."
source .venv/bin/activate

python3 -m apps.trading-engine.bridge_router \
    --token USDC \
    --amount "$AMOUNT_USDC" \
    --from "$SOURCE" \
    --to "$DESTINATION" \
    --max-slippage 0.05

echo "Cross-chain transfer initiated."
