#!/bin/bash
set -e

# Install Circom if not already installed
if ! command -v circom &> /dev/null; then
    echo "Installing Circom..."
    curl -L -o circom https://github.com/iden3/circom/releases/download/v2.1.4/circom-linux-amd64
    chmod +x circom
    sudo mv circom /usr/local/bin
fi

# Compile the circuit
echo "Compiling circuit..."
start_compile=$(date +%s)
circom example.circom --r1cs --wasm --sym
end_compile=$(date +%s)
compile_time=$((end_compile - start_compile))
echo "Circuit compilation took $compile_time seconds."

# Generate witness
echo "Generating witness..."
start_witness=$(date +%s)
node example_js/generate_witness.js example_js/example.wasm input.json witness.wtns
end_witness=$(date +%s)
witness_time=$((end_witness - start_witness))
echo "Witness generation took $witness_time seconds."

# Generate proof
echo "Setting up and generating proof..."
start_proof=$(date +%s)
snarkjs groth16 setup example.r1cs ppot_0080_10.ptau example.zkey
snarkjs groth16 prove example.zkey witness.wtns proof.json public.json
end_proof=$(date +%s)
proof_time=$((end_proof - start_proof))
echo "Proof generation took $proof_time seconds."

# Verify proof
echo "Verifying proof..."
start_verify=$(date +%s)
snarkjs groth16 verify verification_key.json public.json proof.json
end_verify=$(date +%s)
verify_time=$((end_verify - start_verify))
echo "Proof verification took $verify_time seconds."

# Summary of times
total_time=$((compile_time + witness_time + proof_time + verify_time))
echo "Total time taken: $total_time seconds."
