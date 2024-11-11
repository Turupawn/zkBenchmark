#!/bin/bash
set -e

# Install Noir if not already installed
if ! command -v noir &> /dev/null; then
    curl -L noirup.dev | bash
    noirup
fi

# Proceed with the rest of the script for proof generation
echo "Proceeding with proof generation..."

# Compile the Fibonacci Noir circuit
echo "Compiling Fibonacci Noir circuit..."
start_compile=$(date +%s%3N)  # Time in milliseconds
noir compile fibonacci.noir --output fibonacci
end_compile=$(date +%s%3N)
compile_time=$((end_compile - start_compile))
echo "Circuit compilation took $compile_time milliseconds."

# Generate witness
echo "Generating witness for Fibonacci..."
start_witness=$(date +%s%3N)
noir generate-witness --circuit fibonacci.r1cs --input inputNoir.json --witness witness.wtns
end_witness=$(date +%s%3N)
witness_time=$((end_witness - start_witness))
echo "Witness generation took $witness_time milliseconds."

# Generate proving and verification keys, and generate proof
echo "Setting up and generating proof..."
start_proof=$(date +%s%3N)
noir setup fibonacci.r1cs fibonacci.ptau fibonacci.zkey

# Generate the verification key
noir export-verification-key fibonacci.zkey verification_key.json

# Generate proof
noir generate-proof --zkey fibonacci.zkey --witness witness.wtns --proof proof.json --public-output public.json
end_proof=$(date +%s%3N)
proof_time=$((end_proof - start_proof))
echo "Proof generation took $proof_time milliseconds."

# Verify proof
#echo "Verifying proof..."
#start_verify=$(date +%s%3N)
#noir verify-proof --verification-key verification_key.json --proof proof.json --public-input public.json
#end_verify=$(date +%s%3N)
#verify_time=$((end_verify - start_verify))
#echo "Proof verification took $verify_time milliseconds."

# Summary of times
total_time=$((compile_time + witness_time + proof_time + verify_time))
echo "Total time taken: $total_time milliseconds."
