#!/bin/bash
# scripts/init-shadow-node.sh

set -e
ROLE=${1:-"shadow"}

if [ "$ROLE" == "master" ]; then
    echo "Promoting this instance to MASTER node. Execution enabled."
    export QUANTFLUX_EXECUTION_ENABLED="true"
    docker restart quantflux-trading-engine
else
    echo "Initializing this instance as SHADOW node. Execution disabled."
    export QUANTFLUX_EXECUTION_ENABLED="false"
    docker-compose -f infra/docker/docker-compose.yml up -d
    echo "Shadow node is syncing data and tracking state securely."
fi
