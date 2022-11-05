module the_move_lang::Address {
    #[test]
    public entry fun test_address_type() {
        let addr: address = @0x1; //                                    0x00000000000000000000000000000001
        assert!(addr == @0x1, 0);
        // std::debug::print(&addr);

        let addr: address = @0x42; //                                   0x00000000000000000000000000000042
        assert!(addr == @0x42, 0);
        // std::debug::print(&addr);

        let addr: address = @0xDEADBEEF; //                             0x000000000000000000000000DEADBEEF
        assert!(addr == @0xDEADBEEF, 0);
        // std::debug::print(&addr);

        let addr : address = @0x0000000000000000000000000000000A; //    0x0000000000000000000000000000000A
        assert!(addr == @0x0000000000000000000000000000000A, 0);
        // std::debug::print(&addr);

        let addr : address = @std; //   0x0000000000000000000000000000000000000000000000000000000000000001
        assert!(addr == @std, 0);
        // std::debug::print(&addr);

        let addr : address = @66; //    0x0000000000000000000000000000000000000000000000000000000000000042
        assert!(addr == @66, 0);
        // std::debug::print(&addr);

        let addr : address = @0x42; //  0x0000000000000000000000000000000000000000000000000000000000000042
        assert!(addr == @0x42, 0);
        // std::debug::print(&addr);
    }

    // address type
    //
    // function
    // - exists
    // - borrow_global
    // - borrow_global_mut
    // - move_from

    // singer
    // function
    // - move_to
}