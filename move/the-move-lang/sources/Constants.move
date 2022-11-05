module the_move_lang::Constants {
    // define my error code
    const MY_ERROR_CODE: u64 = 0;

    // define my address
    const MY_ADDRESS: address = @0x1;

    const FLAG: bool = true;

    const HELLO_WORLD: vector<u8> = b"hello world";

    const HEX_BYTES: vector<u8> = x"DEADBEEF";

    const RULE: bool = true && false;
    const CAP: u64 = 10 * 100 + 1;
    // const SHIFTY: u8 = {
    //     (1 << 1) * (1 << 2) * (1 << 3) * (1 << 4)
    // };
    const HALF_MAX: u128 = 340282366920938463463374607431768211455 / 2;
    const EQUAL: bool = 1 == 1;


    #[test(account = @0x1)]
    public entry fun test_constants_type() {
        assert!(MY_ERROR_CODE == 0, MY_ERROR_CODE);
        assert!(MY_ADDRESS == @0x1, MY_ERROR_CODE);
        assert!(FLAG == true, MY_ERROR_CODE);
        assert!(HELLO_WORLD == b"hello world", MY_ERROR_CODE);
        // assert!(HEX_BYTES == HEX_BYTES, MY_ERROR_CODE);
        assert!(RULE == false, MY_ERROR_CODE);
        assert!(CAP == 1001, MY_ERROR_CODE);
        assert!(EQUAL == true, MY_ERROR_CODE);
        // std::debug::print(&HALF_MAX);
    }
}