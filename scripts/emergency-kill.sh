#!/bin/bash
# scripts/emergency-kill.sh

set -e
echo "⚠️ INITIATING EMERGENCY KILL SWITCH ⚠️"
echo "This will flatten all open positions and halt the trading engine."
read -p "Type 'CONFIRM' to execute: " -r
echo

if [[ $REPLY == "CONFIRM" ]]; then
    echo "Broadcasting panic signal to risk engine..."
    source .venv/bin/activate
    python3 -m apps.risk-engine.panic_button --action "FLATTEN_ALL" --cancel-open-orders
    
    echo "Stopping trading-engine containers..."
    docker stop quantflux-trading-engine || true
    
    echo "System is now in safe mode. All trading halted."
else
    echo "Kill switch aborted."
fi
