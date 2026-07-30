#!/bin/bash
# scripts/bootstrap.sh

set -e
echo "Starting Quantflux bootstrap..."

command -v node >/dev/null 2>&1 || { echo >&2 "Node.js is required. Aborting."; exit 1; }
command -v python3 >/dev/null 2>&1 || { echo >&2 "Python 3 is required. Aborting."; exit 1; }
command -v docker >/dev/null 2>&1 || { echo >&2 "Docker is required. Aborting."; exit 1; }

echo "Installing frontend dependencies..."
cd apps/web && npm install
cd ../../

echo "Installing Python dependencies for engines..."
python3 -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt

if [ ! -f .env ]; then
    cp .env.example .env
    echo ".env created. Please configure your API keys and RPC endpoints."
fi

echo "Bootstrap complete."
