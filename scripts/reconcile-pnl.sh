#!/bin/bash
# scripts/reconcile-pnl.sh

set -e
DATE=${1:-$(date +"%Y-%m-%d")}

echo "Initiating PnL reconciliation for trades executed on $DATE..."
source .venv/bin/activate

python3 -m apps.risk-engine.auditor \
    --date "$DATE" \
    --compare-live-broker true \
    --output-discrepancies ./data/logs/reconciliation_errors.json

echo "Reconciliation complete. Any discrepancies have been logged."
