use dep::std;

fn main(root : pub Field,
  index : Field,
  hash_path : [Field; 2],
  nullifier: Field, priv_key: Field,
  recipient: pub Field) -> pub Field
{
    let note_commitment = std::hash::pedersen_hash([priv_key, nullifier]);
    let nullifierHash = std::hash::pedersen_hash([nullifier]);

    let computed_root = std::merkle::compute_merkle_root(note_commitment, index, hash_path);
    assert(root == computed_root);

    nullifierHash
}