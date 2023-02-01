module merkle_tree::merkle_tree {
    use std::hash;
    use std::vector;

    struct MerkleProof has drop {
        // data of leaf being checked
        leaf: vector<u8>,
        // the position in the tree of the leaf being checked
        pos: u64,
        // the path of hashes, from bottom to the top of tree
        path: vector<vector<u8>>,
    }

    public fun new(leaf: vector<u8>, pos: u64, path: vector<vector<u8>>) : MerkleProof {
        MerkleProof { leaf, pos, path }
    }

    // hash a leaf value.
    public fun hash_leaf(leaf: vector<u8>) : vector<u8> {
        let hasher_value : vector<u8> = b"leaf:";
        vector::append(&mut hasher_value, leaf);
        hash::sha2_256(hasher_value)
    }

    // hash an internal node.
    public fun hash_internal_node(left: vector<u8>, right: vector<u8>) : vector<u8> {
        let hasher_value : vector<u8> = b"node";
        vector::append(&mut hasher_value,left);
        vector::append(&mut hasher_value,right);
        hash::sha2_256(hasher_value)
    }

    //  The prefixes in the two functions above are a security measure.
    //  They provide domain separation, meaning that the domain of a leaf hash
    //  is seperated from the domain of an internal node hash.
    // This ensures that the verifier cannot mistake a leaf hash for
    // an internal node hash, and vice versa.

    /// Takes as input a list of leaves and a leaf position (pos).
    /// Returns the Merkle proof for the leaf at pos.
    public fun gen_merkle_proof(leaves: vector<vector<u8>>, pos: u64): vector<vector<u8>> {
        // let height = (leaves.len() as f32).log2().ceil() as usize;
        // assert!(height < MAX_HEIGHT, "Too many leaves.");

        // let mut state = leaves
        //     .iter()
        //     .map(|v| hash_leaf(v.clone()))
        //     .collect::<Vec<_>>();

        // // Pad the list of hashed leaves to a power of two
        // let pad_len = 2_i32.pow(height as u32) - leaves.len() as i32;
        // let mut pad = vec![b"\x00".to_vec(); pad_len as usize];
        // state.append(&mut pad);

        // // initialize a list that will contain the hashes in the proof
        // let mut path = vec![];

        // let mut level_pos = pos; // local copy of pos

        // for _level in 0..height {
        //     let sibling = if level_pos % 2 == 0 {
        //         state[level_pos + 1].clone()
        //     } else {
        //         state[level_pos - 1].clone()
        //     };
        //     path.push(sibling);
        //     level_pos /= 2;

        //     // hash internal nodes in the tree
        //     state = (0..state.len())
        //         .step_by(2)
        //         .map(|i| hash_internal_node(state[i].clone(), state[i + 1].clone()))
        //         .collect::<Vec<_>>();
        // }

        // path

        let result : vector<vector<u8>> = vector[];

        result
    }

    /// computes a root from the given leaf and Merkle proof.
    public fun compute_merkle_root_from_proof(proof: MerkleProof) : vector<u8> {
        let pos = proof.pos;
        let path = proof.path;
        let root = hash_leaf(proof.leaf);

        while (!vector::is_empty(&path)) {
            let (left, right) = if (pos % 2 == 0) {
                (root,vector::remove(&mut path, 0))
            } else {
                (vector::remove(&mut path, 0),root)
            };

            root = hash_internal_node(left, right);

            pos = pos >> 1;
        };

        root
    }

}