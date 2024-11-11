#!/bin/bash
set -e

# Install Circom if not already installed
if ! command -v circom &> /dev/null; then
    echo "Installing Circom..."
    curl -L https://github.com/iden3/circom/releases/download/v2.0.5/circom-linux-amd64.tar.gz | tar xz
    sudo mv circom /usr/local/bin
fi

# Compile the circuit
circom example.circom --r1cs --wasm --sym

# Generate witness
node example_js/generate_witness.js example_js/example.wasm input.json witness.wtns

# Generate proof and verify
snarkjs groth16 setup example.r1cs ppot_0080_10.ptau example.zkey
snarkjs groth16 prove example.zkey witness.wtns proof.json public.json
snarkjs groth16 verify verification_key.json public.json proof.json
