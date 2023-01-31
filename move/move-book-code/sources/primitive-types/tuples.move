module move_book_code::tuples {
     fun examples(cond: bool) {
        let () = ();
        let (_x, _y): (u8, u64) = (0, 1);
        let (_a, _b, _c, _d) = (@0x0, 0, false, b"");

        () = ();
        (_x, _y) = if (cond) (1, 2) else (3, 4);
        (_a, _b, _c, _d) = (@0x1, 1, true, b"1");
    }

    fun examples_with_function_calls() {
        let () = returns_unit();
        let (_x, _y): (bool, bool) = returns_2_values();
        let (_a, _b, _c, _d) = returns_4_values(&0);

        () = returns_unit();
        (_x, _y) = returns_2_values();
        (_a, _b, _c, _d) = returns_4_values(&1);
    }

    
    fun returns_unit() { }
    fun returns_unit_1() { }
    fun returns_unit_2(): () { }
    fun returns_unit_3(): () { () }

    fun returns_2_values(): (bool, bool) {
        (false, true)
    }

    fun returns_3_values(): (u64, bool, address) {
        (0, false, @0x42)
    }
    fun returns_4_values(x: &u64): (&u64, u8, u128, vector<u8>) {
        (x, 0, 1, b"foobar")
    }

    #[test]
    fun test_tuples() {
        examples_with_function_calls();
        examples(true);
    }
}