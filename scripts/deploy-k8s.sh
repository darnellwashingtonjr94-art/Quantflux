#!/bin/bash
# scripts/deploy-k8s.sh

set -e
NAMESPACE="quantflux-prod"

echo "Applying Kubernetes manifests to $NAMESPACE namespace..."
kubectl apply -f infra/k8s/namespaces.yaml
kubectl apply -f infra/k8s/configmaps.yaml
kubectl apply -f infra/k8s/secrets.yaml

for deployment in infra/k8s/deployments/*.yaml; do
    kubectl apply -f "$deployment" -n "$NAMESPACE"
done

echo "Triggering rollout restart for all microservices..."
kubectl rollout restart deployment -n "$NAMESPACE"
