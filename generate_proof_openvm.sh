#!/bin/bash
set -e

echo "Installing OpenVM..."
rustup toolchain install nightly
cargo +nightly install --git http://github.com/openvm-org/openvm.git cargo-openvm
cargo openvm --version

rustup install nightly-2024-10-30
rustup component add rust-src --toolchain nightly-2024-10-30

cargo openvm --version

# Proceed with the rest of the script for proof generation
echo "Proceeding with proof generation..."

cd fibonacci_openvm

# Build the project
cargo openvm build

# Prove the Fibonacci circuit
echo "Checking Fibonacci OpenVM circuit..."
#start_check=$(date +%s%3N)  # Time in milliseconds
#OPENVM_FAST_TEST=1 cargo openvm prove app --input "0x0A00000000000000"
ls
OPENVM_FAST_TEST=1 cargo openvm prove app --input "0x000000000000002A"
ls
#end_proof=$(date +%s%3N)
#proof_time=$((end_proof - start_proof))
#echo "Circuit check took $proof_time milliseconds."

# Summary of times
#total_time=$((proof_time))
#echo "Total time taken: $total_time milliseconds."
