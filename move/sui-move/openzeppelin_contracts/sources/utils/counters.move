// SPDX-License-Identifier: MIT
// OpenZeppelin Contracts v0.0.1 (utils/counters.move)
module openzeppelin_contracts::counters {
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
    struct Counter {
        // This variable should never be directly accessed by users of the library: interactions must be restricted to
        // the library's function. As of Solidity v0.5.2, this cannot be enforced, though there is a proposal to add
        // this feature: see https://github.com/ethereum/solidity/issues/4637
        _value: u256 // default: 0
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