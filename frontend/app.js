import { BarretenbergBackend } from '@noir-lang/backend_barretenberg';
import { Noir } from '@noir-lang/noir_js';
import circuit from './noirCircuit.json';

const sendProof = async (x, y) => {
    const backend = new BarretenbergBackend(circuit);
    const noir = new Noir(circuit, backend);
    const input = { n: x };
    document.getElementById("web3_message").textContent="Generating proof... ⌛"
    var proof = await noir.generateFinalProof(input);
    document.getElementById("web3_message").textContent="Generating proof... ✅"
    proof = "0x" + ethereumjs.Buffer.Buffer.from(proof.proof).toString('hex')
    y = ethereumjs.Buffer.Buffer.from([y]).toString('hex')
    y = "0x" + "0".repeat(64-y.length) + y

    document.getElementById("public_input").textContent = "public input: " + y
    document.getElementById("proof").textContent = "proof: " + proof
}
window.sendProof=sendProof;