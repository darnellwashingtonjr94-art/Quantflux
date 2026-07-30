#!/bin/bash
# scripts/start-metrics.sh

set -e
echo "Provisioning Prometheus and Grafana monitoring stack..."

docker-compose -f infra/docker/metrics-compose.yml up -d

echo "Monitoring stack live."
echo "Grafana Dashboard: http://localhost:3000 (admin/admin)"
echo "Prometheus Targets: http://localhost:9090/targets"
