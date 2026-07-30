#!/bin/bash
# scripts/sync-macro-events.sh

set -e
echo "Fetching upcoming macroeconomic events and calendar shocks..."
source .venv/bin/activate

python3 -m libs.data.macro_calendar_sync \
    --lookahead-days 14 \
    --db-url "$DATABASE_URL"

echo "Macro calendar successfully synchronized with the risk engine."
