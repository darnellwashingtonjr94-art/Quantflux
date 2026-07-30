#!/bin/bash
# scripts/obfuscate-alpha.sh

set -e
echo "Initiating source protection utility for proprietary strategies..."
source .venv/bin/activate

TARGET_DIR="apps/trading-engine/strategies"
BUILD_DIR="build/obfuscated_strategies"

mkdir -p "$BUILD_DIR"

# Compile Python strategies to C-extensions
for strategy in "$TARGET_DIR"/*.py; do
    if [ "$(basename "$strategy")" != "__init__.py" ]; then
        echo "Obfuscating $strategy..."
        cythonize -i -3 "$strategy"
        mv "$TARGET_DIR"/*.so "$BUILD_DIR/"
    fi
done

echo "Obfuscation complete. Compiled binaries moved to $BUILD_DIR"
