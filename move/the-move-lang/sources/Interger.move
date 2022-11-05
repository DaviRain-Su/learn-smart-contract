module the_move_lang::Integer {
    #[test]
    public entry fun test_integer_type_u8() {
        let min_u8 = 0u8;
        assert!(min_u8 == 0u8, 0);

        let max_u8 = 255u8;
        assert!(max_u8 == 255u8, 0);

        let min_u64 = 0u64;
        assert!(min_u64 == 0u64, 0);
    }

    /// calculate max value
    public fun calculate_max_value(num: u128): u128 {
        let counter = 0u128;
        let sum = 0u128;

        loop {
            if (counter == num) {
                break
            };

            sum = sum + (1 << (counter as u8));
            counter = counter + 1;
        };

        sum
    }


    #[test(account = @0x1)]
    public  entry fun test_calculate_max_value() {
        let r = calculate_max_value(8);
        assert!(r == 255, 0);
    }

    #[test(account = @0x1)]
    public entry fun test_integer_literal() {
        // literals with explicit annotations
        let _explicit_u8 = 1u8;
        let _explicit_u64 = 2u8;
        let _explicit_u128 = 3u8;

        // literals with simple inference
        let _simple_u8: u8 = 1;
        let _simple_u64: u64 = 2;
        let _simple_u128: u128 = 3;

        // literals with more complex inference
        let complex_u8  = 1; // inferred : u8
        // right hand argument to shift must be u8
        let _unused = 10 << complex_u8;

        let x: u8 = 0;
        let complex_u8 = 2;// inferred : u8
        // arguments to '+' must have the same type
        let _unused = x + complex_u8;

        // literals can be written in hex
        let _hex_u8: u8 = 0x1;
        let _hex_u64: u64 = 0xCAFE;
        let _hex_u128 : u128 = 0xDEADBEEF;

        // arithmetic
        let a = 2;
        let b = 1;
        let c = a + b;
        assert!(c == 3, 1);
        let c = a - b;
        assert!(c == 1, 1);
        let c = a * b;
        assert!(c == 2, 1);
        let c = a % b;
        assert!(c == 0, 0);
        let c = a / b;
        assert!(c == 2, 1);

        // bitwise
        let c = a & b;
        assert!(c == 0, 0);
        let c = a | b;
        assert!(c == 3, 0);
        let c = a ^ b;
        assert!(c == 3, 0);

        // comparisons
        let c = a == b;
        assert!(c == false, 0);
        let c = a != b;
        assert!(c == true, 0);

        // bit shift
        let c = a << b;
        assert!(c == 4, 0);
        let c = a >> b;
        assert!(c == 1, 0);
    }
}