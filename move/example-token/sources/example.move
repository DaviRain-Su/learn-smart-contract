module example_token::ExampleToken {
    use std::hash;
    use std::signer;

    const EXAMPLE_TOKEN_NAME: vector<u8> = b"ET";

    struct Resource has key { i: u64 }

    public fun publish(account: &signer) {
        move_to(account, Resource { i: 10})
    }

    public fun write(account: &signer, i: u64) acquires Resource {
        borrow_global_mut<Resource>(signer::address_of(account)).i = i;
    }

    public fun unpublish(account: &signer) acquires Resource {
        let Resource { i: _ } = move_from(signer::address_of(account));
    }

    public fun hash_256(data: vector<u8>): vector<u8> {
        hash::sha2_256(data)
    }

    public fun hash_3256(data: vector<u8>): vector<u8> {
        hash::sha3_256(data)
    }

    #[test]
    fun test_example_token() {
        use std::debug;
        let ret = hash_256(EXAMPLE_TOKEN_NAME);
        debug::print<vector<u8>>(&ret);
        let ret = hash_3256(EXAMPLE_TOKEN_NAME);
        debug::print<vector<u8>>(&ret);
    }
}