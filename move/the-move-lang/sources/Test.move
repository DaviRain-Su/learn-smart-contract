#[test_only]
module the_move_lang::Test {
    struct MyCoin has key { value: u64 }

    public fun make_sure_non_zero_coin(coin: MyCoin): MyCoin {
        assert!(coin.value > 0, 0);
        coin
    }

    public fun has_coin(addr: address): bool {
        exists<MyCoin>(addr)
    }

    #[test]
    fun make_sure_non_zero_coin_passes() {
        let coin = MyCoin { value: 1 };
        let MyCoin { value: _ } = make_sure_non_zero_coin(coin);
    }

    #[test]
    // Or #[expected_failure] if we don't care about the abort code
    #[expected_failure(abort_code = 0)]
    fun make_sure_zero_coin_fails() {
        let coin = MyCoin { value: 0 };
        let MyCoin { value: _ } = make_sure_non_zero_coin(coin);
    }

    #[test_only] // test only helper function
    fun publish_coin(account: &signer) {
        move_to(account, MyCoin { value: 1 })
    }

    #[test(a = @0x1, b = @0x2)]
    fun test_has_coin(a: signer, b: signer) {
        publish_coin(&a);
        publish_coin(&b);
        assert!(has_coin(@0x1), 0);
        assert!(has_coin(@0x2), 1);
        assert!(!has_coin(@0x3), 1);
    }

    #[test(account = @0x1)]
    fun test_is_no_correct(account: &signer){
        use std::signer;
        use std::debug;

        debug::print(account);
        let address = signer::address_of(account);
        debug::print(&address);
        let address = signer::borrow_address(account);
        debug::print(address);
    }

    #[test]
    #[expected_failure]
    public fun this_test_will_abort_and_pass() { abort 1 }


    #[test]
    #[expected_failure]
    public fun test_will_error_and_pass() { 1/0; }

    // #[test]
    // #[expected_failure(abort_code = 0)]
    // public fun test_will_error_and_fail() { 1 / 0; }

    #[test, expected_failure] // Can have multiple in one attribute. This test will pass.
    public fun this_other_test_will_abort_and_pass() { abort 1 }

    #[test(arg = @0xC0FFEE)] // OK
    fun this_is_correct_now(arg: signer) {
        std::debug::print(&arg);
    }

    // #[test(wrong_arg_name = @0xC0FFEE)] // Not correct: arg name doesn't match
    // fun this_is_incorrect(arg: signer) {  }

    #[test(a = @0xC0FFEE, b = @0xCAFE)] // OK. We support multiple signer arguments, but you must always provide a value for that argument
    fun this_works(a: signer, b: signer) {
        std::debug::print(&a);
        std::debug::print(&b);
    }

    // somewhere a named address is declared
    #[test_only] // test-only named addresses are supported
    const TEST_NAMED_ADDR: address = @0x1;

    // #[test, expected_failure(abort_code = 1)]  // This test will fail
    // fun this_test_should_abort_and_fail() { abort 0 }

    #[test]
    #[expected_failure(abort_code = 0)]  // This test will pass
    fun this_test_should_abort_and_pass_too() { abort 0 }

    // #[test_only]  // test only attributes can be attached to modules
    // module abc { ... }

    #[test_only] // test only attributes can be attached to named addresses
    const ADDR: address = @0x1;

    // #[test_only] // .. to uses
    // use 0x1::some_other_module;

    #[test_only] // .. to structs
    struct SomeStruct { }

    #[test_only] // .. and functions. Can only be called from test code, but not a test
    fun test_only_function() { }
}