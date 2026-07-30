#!/bin/bash
# scripts/detect-anomalies.sh

set -e
echo "Starting anomaly detection worker..."
source .venv/bin/activate

# Continuously tail and analyze execution logs for microstructure anomalies
python3 -m libs.analytics.anomaly_worker \
    --log-source ./data/logs/execution.log \
    --sensitivity high \
    --alert-channel "discord"

echo "Anomaly detector is actively monitoring the event stream."
