module merkle_tree::merkle_tree {
    use std::hash;
    use std::vector;
    use openzeppelin_contracts::math;

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

    public fun path(proof: &MerkleProof): &vector<vector<u8>> {
        &proof.path
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
        let height = math::log2_with_rounding((vector::length(&leaves) as u256), 0);

        let state = vector[];
        let count = 0;
        loop {
            if (count == vector::length(&leaves)) {
                break
            };
            let value = vector::borrow(&leaves, count);
            vector::push_back(&mut state, hash_leaf(*value));
            count = count + 1;
        };

        
        // Pad the list of hashed leaves to a power of two
        let pad_len = math::pow_u64(2, (height as u8)) - vector::length(&leaves);
        let pad = vector[];
        let count = 0;
        loop {
            if (count == pad_len) {
                break
            };
            vector::push_back(&mut pad, b"\x00");
            count = count + 1;
        };
        vector::append(&mut state, pad);
        
        // // initialize a list that will contain the hashes in the proof
        let path: vector<vector<u8>> = vector[];

        let level_pos = pos; // local copy of pos

        let count = 0;
        loop {
            if (count == height) {
                break
            };

            let sibling = if (level_pos % 2 == 0) {
                vector::borrow(&state, level_pos + 1)
            } else {
                vector::borrow(&state, level_pos - 1)
            };

            vector::push_back(&mut path, *sibling);

            level_pos = level_pos / 2;

            let new_state = vector[];

            let inner_count = 0;
            loop {
                if (inner_count == vector::length(&state)) {
                    break
                };
                let left_v = vector::borrow(&state, inner_count);
                let right_v = vector::borrow(&state, inner_count + 1);
                let v = hash_internal_node(*left_v, *right_v);
                vector::push_back(&mut new_state, v);
                inner_count = inner_count + 2;
            };
            state = new_state;
            count = count + 1;
        };

        path
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

#[test_only]
module merkle_tree::test_merkle_tree {
    use merkle_tree::merkle_tree;
    use std::vector;

    #[test]
    fun test_merkle_tree() {
        let root = vector[214, 162, 27, 178, 251, 133, 232, 90, 225, 54, 51, 3, 226, 157, 58, 178, 181, 50, 123, 161, 184, 21, 241, 72, 52, 48, 228, 53, 242, 148, 165, 59];

        let count = 0;
        
        let leaves = vector[];
        loop {
            if (count == 1000) {
                break
            };

            vector::push_back(&mut leaves, b"data item");
            count = count + 1;
        };

        // Generate proof for leaf #743
        let pos = 743;
        let path = merkle_tree::gen_merkle_proof(leaves, pos);
        let leaf = vector::borrow(&leaves, pos);
        let proof = merkle_tree::new(*leaf, pos, path);

        // # Verify proof
        let computed_root = merkle_tree::compute_merkle_root_from_proof(proof);
        assert!(root == computed_root, 0);
    }
}