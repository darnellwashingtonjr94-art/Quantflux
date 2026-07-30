#!/bin/bash
# scripts/ws-watchdog.sh

set -e
MAX_STALE_MS=500
echo "Monitoring WebSocket data streams for stale feeds (Threshold: ${MAX_STALE_MS}ms)..."

source .venv/bin/activate
python3 -m libs.shared.ws_health_check \
    --max-delay-ms "$MAX_STALE_MS" \
    --trigger-restart true \
    --alert-channel "telegram"
