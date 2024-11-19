#!/bin/bash
set -e

export PATH=$PATH:$HOME/.risc0/bin

echo "Installing Risc0..."
curl -L https://risczero.com/install | bash
rzup install

# Proceed with the rest of the script for proof generation
echo "Proceeding with proof generation..."

cd fibonacci_risc0

# Prove the Fibonacci circuit
echo "Checking Fibonacci Risc0 circuit..."
start_check=$(date +%s%3N)  # Time in milliseconds
RISC0_DEV_MODE=0 cargo run --release
end_proof=$(date +%s%3N)
proof_time=$((end_proof - start_proof))
echo "Circuit check took $proof_time milliseconds."

# Summary of times
total_time=$((proof_time))
echo "Total time taken: $total_time milliseconds."
