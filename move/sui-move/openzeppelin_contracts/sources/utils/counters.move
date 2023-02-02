// SPDX-License-Identifier: MIT
// OpenZeppelin Contracts v0.0.1 (utils/counters.move)
module openzeppelin_contracts::counters {
    use sui::object::UID;
    use sui::object;
    use sui::tx_context::{Self, TxContext};
    use sui::transfer;

    // Counter: decrement overflow
    const COUNTER_DECREMENT_OVERFLOW: u64 = 0;

    /**
    * @title Counters
    * @author Davirain (@davirain)
    * @dev Provides counters that can only be incremented, decremented or reset. This can be used e.g. to track the number
    * of elements in a mapping, issuing ERC721 ids, or counting request ids.
    *
    * Include with `using Counters for Counters.Counter;`
    */
    struct Counter has key {
        id: UID,
        // This variable should never be directly accessed by users of the library: interactions must be restricted to
        // the library's function. As of Solidity v0.5.2, this cannot be enforced, though there is a proposal to add
        // this feature: see https://github.com/ethereum/solidity/issues/4637
        _value: u256 // default: 0
    }

    public fun create(value: u256, ctx: &mut TxContext) {
        let counter_object = Counter {
            id: object::new(ctx),
            _value: value
        };
        transfer::transfer(counter_object, tx_context::sender(ctx))
    }

    public fun current(counter: &Counter): u256 {
        counter._value
    }

    public fun increment(counter: &mut Counter) {
        counter._value = counter._value + 1;
    }

    public fun decrement(counter: &mut Counter) {
        let value = counter._value;
        assert!(value > 0, COUNTER_DECREMENT_OVERFLOW);
        counter._value = counter._value - 1;
    }

    public fun reset(counter: &mut Counter) {
        counter._value = 0;
    }
}

#[test_only]
module openzeppelin_contracts::test_counters {
    use sui::test_scenario;
    use openzeppelin_contracts::counters::{Self, Counter};

    #[test]
    fun test_counter() {
        let owner = @0x1;
        // Create a Counter and transfer it to @owner.
        let scenario_val = test_scenario::begin(owner);
        let scenario = &mut scenario_val;
        {
            let ctx = test_scenario::ctx(scenario);
            counters::create(1, ctx);
        };
        // Check that @not_owner does not own the just-created Counter.
        let not_owner = @0x2;
        test_scenario::next_tx(scenario, not_owner);
        {
            assert!(!test_scenario::has_most_recent_for_sender<Counter>(scenario), 0);
        };
        // Check that @owner indeed owns the just-created Counter.
        // Also checks the value fields of the object.
        test_scenario::next_tx(scenario, owner);
        {
            let object = test_scenario::take_from_sender<Counter>(scenario);
            let value = counters::current(&object);
            assert!(value == 1, 0);
            test_scenario::return_to_sender(scenario, object);
        };
        test_scenario::next_tx(scenario, owner);
        {
            let object = test_scenario::take_from_sender<Counter>(scenario);
            counters::increment(&mut object);
            let value = counters::current(&object);
            assert!(value == 2, 0);
            test_scenario::return_to_sender(scenario, object);
        };
        test_scenario::next_tx(scenario, owner);
        {
            let object = test_scenario::take_from_sender<Counter>(scenario);
            counters::increment(&mut object);
            counters::increment(&mut object);
            counters::increment(&mut object);
            counters::increment(&mut object);
            let value = counters::current(&object);
            assert!(value == 6, 0);
            test_scenario::return_to_sender(scenario, object);
        };
        test_scenario::next_tx(scenario, owner);
        {
            let object = test_scenario::take_from_sender<Counter>(scenario);
            counters::decrement(&mut object);
            counters::decrement(&mut object);
            counters::decrement(&mut object);
            counters::decrement(&mut object);
            let value = counters::current(&object);
            assert!(value == 2, 0);
            test_scenario::return_to_sender(scenario, object);
        };
        test_scenario::next_tx(scenario, owner);
        {
            let object = test_scenario::take_from_sender<Counter>(scenario);
            counters::reset(&mut object);
            let value = counters::current(&object);
            assert!(value == 0, 0);
            test_scenario::return_to_sender(scenario, object);
        };
        test_scenario::end(scenario_val);
    }
}