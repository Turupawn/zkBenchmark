import { BarretenbergBackend } from '@noir-lang/backend_barretenberg';
import { Noir } from '@noir-lang/noir_js';
import circuit from './artifacts/noirCircuit.json';

const generateNoirProof = async () => {
  const backend = new BarretenbergBackend(circuit);
  const noir = new Noir(circuit);
  const input = { n: 42 };
  document.getElementById("app_message").textContent="Generating proof... ⌛"
  const startTime = performance.now();
  const { witness } = await noir.execute(input);
  var proof = await backend.generateProof(witness);
  const endTime = performance.now();
  document.getElementById("app_message").textContent="Generating proof... ✅"
  proof = "0x" + ethereumjs.Buffer.Buffer.from(proof.proof).toString('hex')
  document.getElementById("proof").textContent = "zkSNARK: " + proof
  const elapsedTime = ((endTime - startTime) / 1000).toFixed(4);
  document.getElementById("app_message").textContent=`It took ${elapsedTime} seconds to generate a Noir proof on your device.✅`
  document.getElementById('proof').style.display = 'block';
}

const generateCircomProof = async () => {
  document.getElementById("app_message").textContent="Generating proof... ⌛"
  const startTime = performance.now();
  const { proof, publicSignals } = await snarkjs.groth16.fullProve( { n: 42, fibo_of_n: 267914296}, "./artifacts/circomCircuit.wasm", "./artifacts/circomCircuit.zkey");
  const endTime = performance.now();
  document.getElementById("app_message").textContent="Generating proof... ✅"
  document.getElementById("proof").textContent = "zkSNARK: " + JSON.stringify(proof)
  const elapsedTime = ((endTime - startTime) / 1000).toFixed(4);
  document.getElementById("app_message").textContent=`It took ${elapsedTime} seconds to generate a Circom proof on your device.✅`
  document.getElementById('proof').style.display = 'block';
}

window.generateNoirProof=generateNoirProof;
window.generateCircomProof=generateCircomProof;