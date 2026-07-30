#!/bin/bash
# scripts/sync-chain-data.sh

set -e
ASSET=${1:-"MONAD/USDT"}
DAYS=${2:-30}

echo "Syncing historical data for $ASSET over the last $DAYS days..."
source .venv/bin/activate

python3 -m libs.data.ingestion_job --asset "$ASSET" --days "$DAYS" --output ./data/market/

echo "Data sync complete. Parquet files saved to data/market/"
