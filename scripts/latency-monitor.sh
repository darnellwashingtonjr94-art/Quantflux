#!/bin/bash
# scripts/latency-monitor.sh

set -e
echo "Starting continuous HFT latency monitoring..."

TARGETS=(
    "api.binance.com"
    "testnet-rpc.monad.xyz"
    "api.mainnet-beta.solana.com"
)

for target in "${TARGETS[@]}"; do
    echo "Pinging $target..."
    ping -c 5 "$target" | tail -1 | awk '{print $4}' | cut -d '/' -f 2 | xargs -I {} echo "Average latency to $target: {} ms"
done
