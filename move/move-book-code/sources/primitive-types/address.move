module move_book_code::address {
    #[test]
    fun test_address() {
        let a: address = @0x1; // 0x00000000000000000000000000000001
        assert!(a == @0x1, 1);
        let a: address = @0x42; // 0x00000000000000000000000000000042
        assert!(a == @0x42, 1);
        let a: address = @0xDEADBEEF; // 0x000000000000000000000000DEADBEEF
        assert!(a == @0xDEADBEEF, 1);
        let a: address = @0x0000000000000000000000000000000A;
        assert!(a == @0x0000000000000000000000000000000A, 1);
        let a: address = @std;
        assert!(a == @std, 1);
        let a: address = @66;
        assert!(a == @66, 1);
        let a: address = @0x42;
        assert!(a == @0x42, 1);
        let a : address = @move_book_code;
        assert!(a == @move_book_code, 1);
    }
}