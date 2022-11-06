// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

// Gas
// How much ether do you need to pay for a transaction?
// You pay gas spent * gas price amount of ehter, where
// - gas is a unit of computation
// - gas spent is the total amount of gas used in a transactions
// - gas price is how much ehter you are willing to pay per gas
// Transaction with higher gas price have higher priority to be included in a block.
// Unspend gas will be refunded.
// Gas Limit 
// There are 2 upper bounds to the amount of gas you can spend
// - gas limit (max amount of gas you'r willing to use for you transaction, set by you)
// - block gas limit(max amount of gas allowed in a block, set by the network)

contract Gas {
    uint public i = 0;

    // Using up all of the gas that you send causes your transaction to fail.
    // State changes are undone.
    // Gas spent are not refunded.
    function forever() public {
        // Here we run a loop until all of the ags are spent
        // and the transaction fails
        while (true) {
            i += 1;
        }
    }
}
