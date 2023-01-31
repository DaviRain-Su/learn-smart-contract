module move_book_code::vector {
    use std::debug;
    use std::vector;

    #[test]
    fun test_vector() {
        let v : vector<bool> = vector[];
        debug::print(&v);
        let v : vector<u8> = vector[0u8, 1u8, 2u8];
        debug::print(&v);
        let v : vector<u128> = vector<u128>[];
        debug::print(&v);
        let v : vector<address> = vector<address>[@0x42, @0x100];
        debug::print(&v);

        assert!(b"" == x"", 0);
        assert!(b"Hello!\n" == x"48656C6C6F210A", 1);
        assert!(b"\x48\x65\x6C\x6C\x6F\x21\x0A" == x"48656C6C6F210A", 2);
        assert!(
            b"\"Hello\tworld!\"\n \r \\Null=\0" ==
                x"2248656C6C6F09776F726C6421220A200D205C4E756C6C3D00",
            3
        );

  
        let v = vector::empty<u64>();
        vector::push_back(&mut v, 5);
        vector::push_back(&mut v, 6);

        assert!(*vector::borrow(&v, 0) == 5, 42);
        assert!(*vector::borrow(&v, 1) == 6, 42);
        assert!(vector::pop_back(&mut v) == 6, 42);
        assert!(vector::pop_back(&mut v) == 5, 42);

        let x = vector::singleton<u64>(10);
        let y = copy x;
        assert!(*vector::borrow(&y, 0) == 10, 42);
    }
}