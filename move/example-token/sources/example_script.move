script {
    use std::debug;
    fun debug_script(account: signer, bool_value: bool, u64_value: u64, address_value: address, hex_value: vector<u8>) {
        debug::print(&account);
        debug::print(&bool_value);
        debug::print(&u64_value);
        debug::print(&address_value);
        debug::print(&hex_value);
    }
}