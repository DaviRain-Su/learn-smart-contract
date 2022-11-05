module erc20::IMCoin {
    use std::signer;

    const MAX_SUPPLY: u64 = 1024;
    const ISSUER: address = @erc20;

    struct Coin has key {
        supply: u64,
        holders: u64,
    }

    struct Balance has key {
        value: u64
    }

    // complete this function
    public fun issue(issuer: &signer) {
        let issuer_addr = signer::address_of(issuer);
        assert!(issuer_addr == ISSUER, 1001);
        assert!(!exists<Coin>(ISSUER), 1002);
        move_to<Coin>(issuer, Coin { supply: 0, holders: 0 });
    }

    // complete this function
    public fun supply(): u64 acquires Coin {
        assert!(exists<Coin>(ISSUER), 1003);

        borrow_global<Coin>(ISSUER).supply
    }

    public fun holders(): u64 acquires Coin {
        assert!(exists<Coin>(ISSUER), 1003);

        borrow_global<Coin>(ISSUER).holders
    }

    // complete this function
    public fun register(account: &signer) acquires Coin {
        assert!(exists<Coin>(ISSUER), 1003);
        let account_address = signer::address_of(account);
        assert!(!exists<Balance>(account_address), 2001);
        let holders = &mut borrow_global_mut<Coin>(ISSUER).holders;
        *holders = *holders + 1;
        move_to<Balance>(account, Balance { value: 0});
    }

    // complete this function
    public fun deposit(issuer: &signer, receiver: address, amount: u64) acquires Balance {
        let issuer_addr = signer::address_of(issuer);
        assert!(issuer_addr == ISSUER, 1001);
        assert!(exists<Coin>(ISSUER), 1003);
        assert!(exists<Balance>(receiver), 2002);
        assert!(amount < MAX_SUPPLY, 1004);

        let receiver_value = &mut borrow_global_mut<Balance>(receiver).value;
        *receiver_value = *receiver_value + amount;
    }

    // complete this function
    public fun balance(addr: address): u64 acquires Balance {
        assert!(exists<Balance>(addr), 2002);

        borrow_global<Balance>(addr).value
    }

    // complete this function
    public fun transfer(sender: &signer, receiver: address, amount: u64) acquires Balance {
        let sender_address = signer::address_of(sender);
        assert!(sender_address != receiver, 2003);

        let sender_value = borrow_global<Balance>(sender_address).value;
        assert!(amount < sender_value, 2004);

        sub_balance(sender_address, amount);
        add_balance(receiver, amount);
    }

    fun add_balance(addr: address, amount: u64) acquires Balance {
        assert!(exists<Balance>(addr), 2002);

        let value_ref = &mut borrow_global_mut<Balance>(addr).value;
        *value_ref = *value_ref + amount;
    }

    fun sub_balance(addr: address, amount: u64) acquires Balance {
        assert!(exists<Balance>(addr), 2002);

        let value_ref = &mut borrow_global_mut<Balance>(addr).value;
        assert!(*value_ref >= amount, 2004);
        *value_ref = *value_ref - amount;
    }
}