#!/bin/bash
# scripts/compile-rust-bindings.sh

set -e
echo "Compiling Rust execution engine into Python bindings..."
source .venv/bin/activate

cd libs/shared/rust_execution_core

# Build the Rust library in release mode and install it into the active Python environment
maturin develop --release

cd ../../../
echo "Rust bindings compiled successfully. Import 'rust_execution_core' in Python engines."
