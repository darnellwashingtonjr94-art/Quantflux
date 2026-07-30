#!/bin/bash
# scripts/ingest-cognitive-data.sh

set -e
echo "Starting ingestion of computer vision and cognitive alternative datasets..."
source .venv/bin/activate

python3 -m libs.data.alt_data_pipeline \
    --module alg0rithm-x-integration \
    --source-type vision_matrix \
    --target-db "postgresql://localhost/quantflux"

echo "Cognitive datasets processed and indexed."
