#!/bin/bash
set -e

# Install Noir if not already installed

export PATH=$PATH:$HOME/.nargo/bin

echo "Installing Noir..."
if ! command -v noir &> /dev/null; then
  mkdir -p $HOME/.nargo/bin && \
  curl -o $HOME/.nargo/bin/nargo-x86_64-unknown-linux-gnu.tar.gz -L https://github.com/noir-lang/noir/releases/download/v0.36.0/nargo-x86_64-unknown-linux-gnu.tar.gz && \
  tar -xvf $HOME/.nargo/bin/nargo-x86_64-unknown-linux-gnu.tar.gz -C $HOME/.nargo/bin/ && \
  echo -e '\nexport PATH=$PATH:$HOME/.nargo/bin' >> ~/.bashrc && \
  source ~/.bashrc
  /home/runner/.nargo/bin/nargo --version
  nargo --version
  ls $HOME/.nargo/bin/
  curl -L bbup.dev | bash
  bbup
fi

# Proceed with the rest of the script for proof generation
echo "Proceeding with proof generation..."

cd mixer_noir

# Check the Mixer Noir circuit
echo "Checking Mixer Noir circuit..."
start_check=$(date +%s%3N)  # Time in milliseconds
nargo check
end_check=$(date +%s%3N)
check_time=$((end_check - start_check))
echo "Circuit check took $check_time milliseconds."

# Execute
echo "Executing Mixer..."
start_execute=$(date +%s%3N)
nargo execute
end_execute=$(date +%s%3N)
execute_time=$((end_execute - start_execute))
echo "Execution took $execute_time milliseconds."

# Generate proving and verification keys, and generate proof
echo "Setting up and generating proof..."
start_proof=$(date +%s%3N)
~/.bb/bb prove -b ./target/mixer.json -w ./target/mixer.gz -o ./target/proo
end_proof=$(date +%s%3N)
proof_time=$((end_proof - start_proof))
echo "Proof generation took $proof_time milliseconds."

# Summary of times
total_time=$((check_time + execute_time + proof_time))
echo "Total time taken: $total_time milliseconds."
