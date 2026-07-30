#!/bin/bash
# scripts/monad-hft-node.sh

set -e
ENV=${1:-"testnet"}

if [ "$ENV" == "testnet" ]; then
    CHAIN_ID=10143
    DEFAULT_RPC="https://testnet-rpc.monad.xyz"
else
    CHAIN_ID=143
    DEFAULT_RPC="https://rpc.monad.xyz"
fi

echo "Bootstrapping Monad-HFT-Node wrapper for chain ID $CHAIN_ID..."
export MONAD_RPC_URL=${MONAD_RPC_URL:-$DEFAULT_RPC}

# Bypasses Python API for raw Rust/C++ executable optimized for parallel EVM execution
./apps/trading-engine/bin/monad-hft-node --rpc "$MONAD_RPC_URL" --latency-mode aggressive
