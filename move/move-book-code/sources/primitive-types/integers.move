module move_book_code::integers {
    #[test]
    fun test_integers() {
       // literals with explicit annotations;
        let explicit_u8 = 1u8;
        assert!(explicit_u8 == 1u8, 1);
        let explicit_u16 = 1u16;
        assert!(explicit_u16 == 1u16, 1);
        let explicit_u32 = 1u32;
        assert!(explicit_u32 == 1u32, 1);
        let explicit_u64 = 2u64;
        assert!(explicit_u64 == 2u64, 1);
        let explicit_u128 = 3u128;
        assert!(explicit_u128 == 3u128, 1);
        let explicit_u256 = 1u256;
        assert!(explicit_u256 == 1u256, 1);

        // literals with simple inference
        let simple_u8: u8 = 1;
        assert!(simple_u8 == 1u8, 1);

        let simple_u16: u16 = 1;
        assert!(simple_u16 == 1u16, 1);
        
        let simple_u32: u32 = 1;
        assert!(simple_u32 == 1u32, 1);
        
        let simple_u64: u64 = 2;
        assert!(simple_u64 == 2u64, 1);
        
        let simple_u128: u128 = 3;
        assert!(simple_u128 == 3u128, 1);
        
        let simple_u256: u256 = 1;
        assert!(simple_u256 == 1u256, 1);

        // literals with more complex inference
        let complex_u8 = 1; // inferred: u8
        assert!(complex_u8 == 1u8, 1);
        
        // right hand argument to shift must be u8
        let _unused = 10 << complex_u8;
        assert!(_unused == 20u64, 1);

        let x: u8 = 0;
        let complex_u8 = 2; // inferred: u8
        // arguments to `+` must have the same type
        let _unused = x + complex_u8;
        assert!(_unused == 2, 1);

        let complex_u128 = 3; // inferred: u128
        assert!(complex_u128 == 3, 1);
        // inferred from function argument type
        // function_that_takes_u128(complex_u128);

        // literals can be written in hex
        let hex_u8: u8 = 0x1;
        assert!(hex_u8 == 1, 1);
        let hex_u16: u16 = 0x1;
        assert!(hex_u16 == 1, 1);
        let hex_u32: u32 = 0x1;
        assert!(hex_u32 == 1, 1);
        let hex_u64: u64 = 0xCAFE;
        assert!(hex_u64 == 51966, 1);
        let hex_u128: u128 = 0xDEADBEEF;
        assert!(hex_u128 == 3735928559, 1);
        let hex_u256: u256 = 0x256;
        assert!(hex_u256 == 598, 1);


        // Arithmetic
        let a = 1 + 1;
        assert!(a == 2, 1);
        let a = 1 - 1;
        assert!(a == 0, 1);
        let a = 1 * 2;
        assert!(a == 2, 1);
        let a = 2 % 2;
        assert!(a == 0, 1);
        let a = 2 / 2;
        assert!(a == 1, 1);
        
        // Bitwise

        let a = 1 & 1;
        assert!(a == 1, 1);
        let a = 1 | 1;
        assert!(a == 1, 1);
        let a = 1 ^ 2;
        assert!(a == 3, 1);

        // Bit shift
        let a = 1 << 1;
        assert!(a == 2, 1);
        let a = 1 >> 1;
        assert!(a == 0, 1);
        
        // Comparisons
        let a = 1 < 1;
        assert!(a == false, 1);
        let a = 1 > 1;
        assert!(a == false, 1);
        let a = 1 <= 1;
        assert!(a == true, 1);
        let a = 1 >= 1;
        assert!(a == true, 1);

        // Equality
        let a = 1 == 1;
        assert!(a == true, 1);
        let a = 1 != 1;
        assert!(a == false, 1);

        // Casting
        // let a = 1u8 == 1u16;
        let a = (1u8 as u16) == 1u16;
        assert!(a == true, 1);
    }
}