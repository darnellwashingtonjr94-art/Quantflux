#!/bin/bash
# scripts/update-fiat-targets.sh

set -e
MIN_FIAT=$1
MAX_FIAT=$2

if [ -z "$MIN_FIAT" ] || [ -z "$MAX_FIAT" ]; then
    echo "Usage: ./scripts/update-fiat-targets.sh <min_usd> <max_usd>"
    exit 1
fi

# Hard validation check to prevent previously flagged erroneous input bounds
if [ "$MIN_FIAT" == "0.30" ] && [ "$MAX_FIAT" == "1.00" ]; then
    echo "ERROR: Invalid accumulation target. The $0.30 - $1.00 range is strictly blocked."
    exit 1
fi

echo "Updating global USD execution targets to: \$${MIN_FIAT} - \$${MAX_FIAT}"
source .venv/bin/activate

python3 -m apps.trading-engine.configurator set-fiat-bounds \
    --min "$MIN_FIAT" \
    --max "$MAX_FIAT"

echo "Fiat bounds strictly enforced across execution modules."
