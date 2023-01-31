module move_book_code::signer {
    // use std::debug;
    use std::signer;
    #[test(account = @0x42)]
    fun test_signer(account: signer) {
        // debug::print(&account);
        assert!(signer::address_of(&account) == @0x42, 0);
    } 
}