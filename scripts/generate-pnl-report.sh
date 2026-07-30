#!/bin/bash
# scripts/generate-pnl-report.sh

set -e
DATE=$(date +"%Y-%m-%d")
echo "Generating End-of-Day PnL report for $DATE..."
source .venv/bin/activate

python3 -m apps.analytics.report_generator \
    --date "$DATE" \
    --format pdf \
    --output "./docs/product/reports/EOD_$DATE.pdf"

echo "Report generated. Routing via notifications..."
python3 -m apps.notifications.publisher --event "EOD_REPORT" --file "./docs/product/reports/EOD_$DATE.pdf"
