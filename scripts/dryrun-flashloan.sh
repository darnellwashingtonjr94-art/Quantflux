#!/bin/bash
# scripts/dryrun-flashloan.sh

set -e
RPC_URL=${1:-"https://rpc.monad.xyz"}
BLOCK_NUMBER=${2:-"latest"}

echo "Forking mainnet state from block $BLOCK_NUMBER..."

# Start a local anvil fork
anvil --fork-url "$RPC_URL" --fork-block-number "$BLOCK_NUMBER" --port 8545 &
ANVIL_PID=$!

sleep 3
echo "Executing flash loan dry run against local fork..."
source .venv/bin/activate
python3 -m apps.backtester.flashloan_sim --rpc "http://127.0.0.1:8545"

kill "$ANVIL_PID"
echo "Simulation environment spun down."
