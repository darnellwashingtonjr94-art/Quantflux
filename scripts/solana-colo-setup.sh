#!/bin/bash
# scripts/solana-colo-setup.sh

set -e
echo "Tuning Linux kernel network parameters for Solana execution..."

# Adjust sysctl parameters for maximum socket buffer sizes
sudo sysctl -w net.core.rmem_max=134217728
sudo sysctl -w net.core.wmem_max=134217728
sudo sysctl -w net.ipv4.tcp_rmem="4096 87380 134217728"
sudo sysctl -w net.ipv4.tcp_wmem="4096 65536 134217728"
sudo sysctl -w net.ipv4.tcp_low_latency=1

echo "Configuring ShredStream local relayer..."
docker run -d --net=host -e JITO_AUTH_KEY=$JITO_KEY jito-shredstream-proxy:latest

echo "Colocation environment tuned."
