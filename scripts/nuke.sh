#!/bin/bash
# scripts/nuke.sh

echo "WARNING: This will destroy all local build caches, Python __pycache__, node_modules, and local logs."
read -p "Are you sure? (y/n): " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
    echo "Nuking..."
    
    find . -type d -name "__pycache__" -exec rm -rf {} +
    find . -type d -name ".pytest_cache" -exec rm -rf {} +
    find . -type d -name ".ruff_cache" -exec rm -rf {} +
    
    find . -type d -name "node_modules" -exec rm -rf {} +
    find . -type d -name ".next" -exec rm -rf {} +
    
    rm -rf data/logs/*
    
    echo "Monorepo is clean."
fi
