#!/bin/bash
# scripts/trigger-notifications.sh

set -e
EVENT_TYPE=${1:-"TEST_ALERT"}
PAYLOAD=${2:-"System ping."}

echo "Routing alert through the Cryptocurrency-Notification framework..."
source .venv/bin/activate

python3 -m apps.notifications.publisher --event "$EVENT_TYPE" --payload "$PAYLOAD" --channels "telegram,discord,sms"

echo "Notification dispatched successfully."
