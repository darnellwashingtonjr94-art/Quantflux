#!/bin/bash
# scripts/sync-tick-to-trade.sh

set -e
PCAP_FILE=${1:-"./data/logs/network.pcap"}

echo "Profiling tick-to-trade latency from packet capture..."
source .venv/bin/activate

python3 -m libs.analytics.latency_profiler \
    --pcap "$PCAP_FILE" \
    --inbound-port 443 \
    --outbound-port 443 \
    --percentile 99

echo "Latency profile generated."
