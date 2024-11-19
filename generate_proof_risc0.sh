#!/bin/bash
set -e

# Install Noir if not already installed

export PATH=$PATH:$HOME/.sp1/bin

echo "Installing SP1..."
if ! command -v noir &> /dev/null; then
  curl -L https://risczero.com/install | bash
  rzup install
fi

# Proceed with the rest of the script for proof generation
echo "Proceeding with proof generation..."

cd fibonacci_risc0

# Check the Fibonacci Noir circuit
echo "Checking Fibonacci Noir circuit..."
start_check=$(date +%s%3N)  # Time in milliseconds
cd program && cargo prove build
end_check=$(date +%s%3N)
check_time=$((end_check - start_check))
echo "Circuit check took $check_time milliseconds."

# Execute
echo "Executing Fibonacci..."
start_execute=$(date +%s%3N)
cd ../script
RUST_LOG=info cargo run --release -- --execute
end_execute=$(date +%s%3N)
execute_time=$((end_execute - start_execute))
echo "Execution took $execute_time milliseconds."

# Generate proving and verification keys, and generate proof
echo "Setting up and generating proof..."
start_proof=$(date +%s%3N)
cd ../script
RUST_LOG=info cargo run --release -- --prove
end_proof=$(date +%s%3N)
proof_time=$((end_proof - start_proof))
echo "Proof generation took $proof_time milliseconds."

# Summary of times
total_time=$((check_time + execute_time + proof_time))
echo "Total time taken: $total_time milliseconds."
