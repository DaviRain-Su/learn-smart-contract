module move_book_code::integers {
    use std::debug;

    public fun display_integers() {
        // literals with explicit annotations;
        let explicit_u8 = 1u8;
        debug::print(&explicit_u8);
        let explicit_u16 = 1u16;
        debug::print(&explicit_u16);
        let explicit_u32 = 1u32;
        debug::print(&explicit_u32);
        let explicit_u64 = 2u64;
        debug::print(&explicit_u64);
        let explicit_u128 = 3u128;
        debug::print(&explicit_u128);
        let explicit_u256 = 1u256;
        debug::print(&explicit_u256);


        // literals with simple inference
        let simple_u8: u8 = 1;
        debug::print(&simple_u8);
        let simple_u16: u16 = 1;
        debug::print(&simple_u16);
        let simple_u32: u32 = 1;
        debug::print(&simple_u32);
        let simple_u64: u64 = 2;
        debug::print(&simple_u64);
        let simple_u128: u128 = 3;
        debug::print(&simple_u128);
        let simple_u256: u256 = 1;
        debug::print(&simple_u256);

        // literals with more complex inference
        let complex_u8 = 1; // inferred: u8
        debug::print(&complex_u8);
        // right hand argument to shift must be u8
        let _unused = 10 << complex_u8;
        debug::print(&_unused);

        let x: u8 = 0;
        let complex_u8 = 2; // inferred: u8
        // arguments to `+` must have the same type
        let _unused = x + complex_u8;
        debug::print(&_unused);

        let complex_u128 = 3; // inferred: u128
        debug::print(&complex_u128);
        // inferred from function argument type
        // function_that_takes_u128(complex_u128);

        // literals can be written in hex
        let hex_u8: u8 = 0x1;
        debug::print(&hex_u8);
        let hex_u16: u16 = 0x1;
        debug::print(&hex_u16);
        let hex_u32: u32 = 0x1;
        debug::print(&hex_u32);
        let hex_u64: u64 = 0xCAFE;
        debug::print(&hex_u64);
        let hex_u128: u128 = 0xDEADBEEF;
        debug::print(&hex_u128); 
        let hex_u256: u256 = 0x256;
        debug::print(&hex_u256);


        // Arithmetic

        let a = 1 + 1;
        debug::print(&a);
        let a = 1 - 1;
        debug::print(&a);
        let a = 1 * 2;
        debug::print(&a);
        let a = 2 % 2;
        debug::print(&a);
        let a = 2 / 2;
        debug::print(&a);
        
        // Bitwise

        let a = 1 & 1;
        debug::print(&a);
        let a = 1 | 1;
        debug::print(&a);
        let a = 1 ^ 2;
        debug::print(&a);

        // Bit shift

        let a = 1 << 1;
        debug::print(&a);
        let a = 1 >> 1;
        debug::print(&a);
        
        // Comparisons

        let a = 1 < 1;
        debug::print(&a);
        let a = 1 > 1;
        debug::print(&a);
        let a = 1 <= 1;
        debug::print(&a);
        let a = 1 >= 1;
        debug::print(&a);

        // Equality

        let a = 1 == 1;
        debug::print(&a);
        let a = 1 != 1;
        debug::print(&a);

        // Casting
        // let a = 1u8 == 1u16;
        let a = (1u8 as u16) == 1u16;
        debug::print(&a);
    }   

    #[test]
    fun test_display_integers() {
        display_integers()
    }
}