#!/bin/bash
# scripts/node-heartbeat.sh

set -e
TARGET_IP=${1:-"127.0.0.1"}
PING_INTERVAL=5

echo "Starting decentralized heartbeat monitor for target: $TARGET_IP"

while true; do
    if ! ping -c 1 -W 2 "$TARGET_IP" > /dev/null; then
        echo "CRITICAL: $TARGET_IP is unresponsive! Dispatching emergency SMS..."
        curl -X POST https://api.twilio.com/2010-04-01/Accounts/$TWILIO_SID/Messages.json \
            --data-urlencode "Body=ALERT: Quantflux trading engine at $TARGET_IP is offline." \
            --data-urlencode "From=$TWILIO_PHONE" \
            --data-urlencode "To=$ADMIN_PHONE" \
            -u "$TWILIO_SID:$TWILIO_AUTH"
        sleep 60 # Cooldown before alerting again
    fi
    sleep "$PING_INTERVAL"
done
