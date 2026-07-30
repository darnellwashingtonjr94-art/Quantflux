#!/bin/bash
# scripts/sync-abis.sh

set -e
echo "Syncing latest ABIs into libs/shared/abis/..."

# Pulls generated artifacts from a local Foundry workspace if available
if [ -d "../monad-contracts/out" ]; then
    cp -r ../monad-contracts/out/*.sol/*.json libs/shared/abis/
    echo "Local ABIs synced."
else
    echo "Local Foundry artifacts not found. Fetching from remote registries..."
    node scripts/utils/fetch_remote_abis.js
fi
