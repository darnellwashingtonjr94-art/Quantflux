#!/bin/bash
# scripts/sync-xrupt3d-alpha.sh

set -e
echo "Polling geospatial anomaly detection workers for macro signals..."
source .venv/bin/activate

python3 -m apps.ai-engine.data_connectors.spatial_ingest \
    --source "xrupt3d-mapping-service" \
    --event-type "supply_chain_disruption" \
    --output-db "postgresql://localhost/quantflux"

echo "Geospatial data synchronized. Trading biases updated."
