#!/bin/bash
# scripts/smart-order-router.sh

set -e
echo "Spinning up Smart Order Routing (SOR) daemon..."
source .venv/bin/activate

python3 -m apps.trading-engine.sor_daemon \
    --update-interval-ms 100 \
    --target-chains "monad,ethereum,arbitrum" \
    --export-redis "redis://localhost:6379/2"

echo "SOR daemon is actively mapping liquidity routes."
