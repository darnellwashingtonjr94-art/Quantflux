#!/bin/bash
# scripts/security-audit.sh

set -e
echo "Running monorepo security audit..."

echo "Scanning for hardcoded secrets (TruffleHog/Gitleaks)..."
docker run --rm -v "$PWD:/path" zricethezav/gitleaks:latest detect --source="/path" -v || echo "⚠️ Secret scan flagged potential issues."

echo "Auditing Node.js dependencies..."
cd apps/web && npm audit --audit-level=high
cd ../../

echo "Auditing Python dependencies..."
source .venv/bin/activate
pip-audit -r requirements.txt

echo "Security audit complete."
