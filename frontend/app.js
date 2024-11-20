import { BarretenbergBackend } from '@noir-lang/backend_barretenberg';
import { Noir } from '@noir-lang/noir_js';
import circuit from './noirCircuit.json';

const sendProof = async () => {
  const backend = new BarretenbergBackend(circuit);
  const noir = new Noir(circuit, backend);
  const input = { n: 42 };
  document.getElementById("app_message").textContent="Generating proof... ⌛"
  const startTime = performance.now();
  var proof = await noir.generateFinalProof(input);
  const endTime = performance.now();
  document.getElementById("app_message").textContent="Generating proof... ✅"
  proof = "0x" + ethereumjs.Buffer.Buffer.from(proof.proof).toString('hex')
  document.getElementById("proof").textContent = "zkSNARK: " + proof
  const elapsedTime = ((endTime - startTime) / 1000).toFixed(4);
  alert(`It took ${elapsedTime} seconds to generate a proof on your device.`);
}

const sendProofCircom = async () => {
  document.getElementById("app_message").textContent="Generating proof... ⌛"
  const startTime = performance.now();
  const { proof, publicSignals } = await snarkjs.groth16.fullProve( { n: 42, fibo_of_n: 267914296}, "./circomCircuit.wasm", "./circomCircuit.zkey");
  const endTime = performance.now();
  document.getElementById("app_message").textContent="Generating proof... ✅"
  document.getElementById("proof").textContent = "zkSNARK: " + JSON.stringify(proof)
  const elapsedTime = ((endTime - startTime) / 1000).toFixed(4);
  alert(`It took ${elapsedTime} seconds to generate a proof on your device.`);
}

window.sendProof=sendProof;
window.sendProofCircom=sendProofCircom;