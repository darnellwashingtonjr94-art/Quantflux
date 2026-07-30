#!/bin/bash
# scripts/automate-staking.sh

set -e
echo "Evaluating margin utilization for staking automation..."
source .venv/bin/activate

# Scans connected wallets and routes idle ETH/SOL into Lido/Jito liquid staking
python3 -m apps.trading-engine.staking_manager \
    --min-idle-time 24h \
    --reserve-margin-usd 50000 \
    --execute-stake true

echo "Idle capital successfully routed to staking contracts."
