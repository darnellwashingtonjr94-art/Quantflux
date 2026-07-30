#!/bin/bash
# scripts/bpf-network-filter.sh

set -e
INTERFACE=${1:-"eth0"}
BPF_PROG="./infra/bpf/drop_noise.o"

echo "Loading eBPF network filter onto $INTERFACE..."

# Ensure the BPF program is compiled
clang -O2 -target bpf -c infra/bpf/drop_noise.c -o "$BPF_PROG"

# Attach to the network interface using XDP (eXpress Data Path)
sudo ip link set dev "$INTERFACE" xdp obj "$BPF_PROG" sec filter

echo "XDP packet acceleration active. Irrelevant traffic is being dropped at the NIC."
echo "To remove: sudo ip link set dev $INTERFACE xdp off"
