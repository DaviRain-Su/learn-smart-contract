// sources/move-tutorial/base_coin.move
module move_book_code::base_coin {
    use std::signer;

    /// Address of the owner of this module
    const MODULE_OWNER: address = @move_book_code;

    /// Error codes
    const ENOT_MODULE_OWNER: u64 = 0;
    const EINSUFFICIENT_BALANCE: u64 = 1;
    const EALREADY_HAS_BALANCE: u64 = 2;

    struct Coin<phantom CoinType> has store {
        value: u64,
    }

    /// Struct representing the balance of each address.
    struct Balance<phantom CoinType> has key {
        coin: Coin<CoinType> // same Coin from Step 1
    }

    /// Publish an empty balance resource under `account`'s address. This function must be called before
    /// minting or transferring to the account.
    public fun publish_balance<CoinType>(account: &signer) {
        let empty_coin = Coin<CoinType> { value: 0 };
        // ensure account has no publish coin 
        assert!(!exists<Balance<CoinType>>(signer::address_of(account)), EALREADY_HAS_BALANCE);
        move_to(account, Balance<CoinType> { coin:  empty_coin });
    }

    /// Mint `amount` tokens to `mint_addr`. Mint must be approved by the module owner.
    public fun mint<CoinType: drop>(mint_addr: address, amount: u64, _witness: CoinType) acquires Balance { 
        // Deposit `amount` of tokens to `mint_addr`'s balance
        deposit(mint_addr, Coin<CoinType> { value: amount });
    }

    /// Returns the balance of `owner`.
    public fun balance_of<CoinType>(owner: address): u64 acquires Balance { 
        borrow_global<Balance<CoinType>>(owner).coin.value
    }

    /// Transfers `amount` of tokens from `from` to `to`.
    public entry fun transfer<CoinType: drop>(from: &signer, to: address, amount: u64, _witness: CoinType) acquires Balance { 
        let check = withdraw<CoinType>(signer::address_of(from), amount);
        deposit<CoinType>(to, check);
    }

    /// Withdraw `amount` number of tokens from the balance under `addr`.
    fun withdraw<CoinType>(addr: address, amount: u64) : Coin<CoinType> acquires Balance {
        let balance = balance_of<CoinType>(addr);
        // balance must be greater than the withdraw amount
        assert!(balance >= amount, EINSUFFICIENT_BALANCE);
        let balance_ref = &mut borrow_global_mut<Balance<CoinType>>(addr).coin.value;
        *balance_ref = balance - amount;
        Coin<CoinType> { value: amount }
    }

    /// Deposit `amount` number of tokens to the balance under `addr`.
    fun deposit<CoinType>(addr: address, check: Coin<CoinType>) acquires Balance {
        let balance = balance_of<CoinType>(addr);
        let balance_ref = &mut borrow_global_mut<Balance<CoinType>>(addr).coin.value;
        let Coin { value } = check;
        *balance_ref = balance + value;
    }

    
    // #[test(account = @0x1)]
    // #[expected_failure] // This test should abort
    // fun mint_non_owner(account: signer) acquires Balance {
    //     // Make sure the address we've chosen doesn't match the module
    //     // owner address
    //     publish_balance(&account);
    //     assert!(signer::address_of(&account) != MODULE_OWNER, 0);
    //     mint(&account, @0x1, 10);
    // }

    // #[test(account = @move_book_code)]
    // fun mint_check_balance(account: signer) acquires Balance {
    //     let addr = signer::address_of(&account);
    //     publish_balance(&account);
    //     mint(&account, @move_book_code, 42);
    //     assert!(balance_of(addr) == 42, 0);
    // }

    //  #[test(account = @0x1)]
    // fun publish_balance_has_zero(account: signer) acquires Balance {
    //     let addr = signer::address_of(&account);
    //     publish_balance(&account);
    //     assert!(balance_of(addr) == 0, 0);
    // }

    //  #[test(account = @0x1)]
    // #[expected_failure] // Can specify an abort code
    // fun publish_balance_already_exists(account: signer) {
    //     publish_balance(&account);
    //     publish_balance(&account);
    // }

    //  #[test]
    // #[expected_failure]
    // fun balance_of_dne() acquires Balance {
    //     balance_of(@0x1);
    // }

    // #[test]
    // #[expected_failure]
    // fun withdraw_dne() acquires Balance {
    //     // Need to unpack the coin since `Coin` is a resource
    //     Coin { value: _ } = withdraw(@0x1, 0);
    // }

    // #[test(account = @0x1)]
    // #[expected_failure] // This test should fail
    // fun withdraw_too_much(account: signer) acquires Balance {
    //     let addr = signer::address_of(&account);
    //     publish_balance(&account);
    //     Coin { value: _ } = withdraw(addr, 1);
    // }

    //  #[test(account = @move_book_code)]
    // fun can_withdraw_amount(account: signer) acquires Balance {
    //     publish_balance(&account);
    //     let amount = 1000;
    //     let addr = signer::address_of(&account);
    //     mint(&account, addr, amount);
    //     let Coin { value } = withdraw(addr, amount);
    //     assert!(value == amount, 0);
    // }
}   