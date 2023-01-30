// sources/move-tutorial/base_coin.move
module move_book_code::base_coin {
    use std::signer;

    /// Address of the owner of this module
    const MODULE_OWNER: address = @move_book_code;

    /// Error codes
    const ENOT_MODULE_OWNER: u64 = 0;
    const EINSUFFICIENT_BALANCE: u64 = 1;
    const EALREADY_HAS_BALANCE: u64 = 2;

    struct Coin has store {
        value: u64,
    }

    /// Struct representing the balance of each address.
    struct Balance has key {
        coin: Coin // same Coin from Step 1
    }

    /// Publish an empty balance resource under `account`'s address. This function must be called before
    /// minting or transferring to the account.
    public fun publish_balance(account: &signer) {
        let empty_coin = Coin { value: 0 };
        // ensure account has no publish coin 
        assert!(!exists<Balance>(signer::address_of(account)), EALREADY_HAS_BALANCE);
        move_to(account, Balance { coin:  empty_coin });
    }

    /// Mint `amount` tokens to `mint_addr`. Mint must be approved by the module owner.
    public fun mint(module_owner: &signer, mint_addr: address, amount: u64) acquires Balance { 
        // Only the owner of the module can initialize this module
        assert!(signer::address_of(module_owner) == MODULE_OWNER, ENOT_MODULE_OWNER);

        // Deposit `amount` of tokens to `mint_addr`'s balance
        deposit(mint_addr, Coin { value: amount });
    }

    /// Returns the balance of `owner`.
    public fun balance_of(owner: address): u64 acquires Balance { 
        borrow_global<Balance>(owner).coin.value
    }

    /// Transfers `amount` of tokens from `from` to `to`.
    public entry fun transfer(from: &signer, to: address, amount: u64) acquires Balance { 
        let check = withdraw(signer::address_of(from), amount);
        deposit(to, check);
    }

    /// Withdraw `amount` number of tokens from the balance under `addr`.
    fun withdraw(addr: address, amount: u64) : Coin acquires Balance {
        let balance = balance_of(addr);
        // balance must be greater than the withdraw amount
        assert!(balance >= amount, EINSUFFICIENT_BALANCE);
        let balance_ref = &mut borrow_global_mut<Balance>(addr).coin.value;
        *balance_ref = balance - amount;
        Coin { value: amount }
    }

    /// Deposit `amount` number of tokens to the balance under `addr`.
    fun deposit(addr: address, check: Coin) acquires Balance {
        let balance = balance_of(addr);
        let balance_ref = &mut borrow_global_mut<Balance>(addr).coin.value;
        let Coin { value } = check;
        *balance_ref = balance + value;
    }

    // Declare a unit test. It takes a signer called `account` with an
    // address value of `0xC0FFEE`.
    #[test(account = @0xC0FFEE)]
    fun test_mint_10(account: signer) acquires Coin {
        let addr = signer::address_of(&account);
        mint(account, 10);
        // Make sure there is a `Coin` resource under `addr` with a value of `10`.
        // We can access this resource and its value since we are in the
        // same module that defined the `Coin` resource.
        assert!(borrow_global<Coin>(addr).value == 10, 0);
    }
}   