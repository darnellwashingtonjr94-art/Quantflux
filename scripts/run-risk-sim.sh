#!/bin/bash
# scripts/run-risk-sim.sh

set -e
STRATEGY=${1:-"all"}

echo "Initializing Math3matics-x quantitative analysis for $STRATEGY..."
source .venv/bin/activate

# Runs thousands of simulated market shocks against current portfolio weights
python3 -m apps.risk-engine.simulate --method monte_carlo --iterations 10000
python3 -m apps.risk-engine.simulate --method historical_var --confidence 0.99

echo "Risk simulations complete. Report generated in docs/product/risk_reports/"
