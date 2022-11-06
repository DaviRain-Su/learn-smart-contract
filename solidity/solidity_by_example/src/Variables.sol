// SPDX-License-Identifier: MIT 
pragma solidity ^0.8.13;

// There are 3 types of variables in Solidity
// local
//  declared inside a function
//  not stored on the blockchain
// state
//  declared outside a function
// stored on the blockchain
//  global (provides information about the blockchain)
contract Variables {
    // State variables are stored on the blockchain.
    string public text = "Hello";
    uint public num = 123;

    function doSomething() public pure {
        // Local variables are not stored on the blockchain
        // uint _i = 456;
        
        // Here are some global variables
        // uint _timestamp = block.timestamp; // current block timestamp
        // address _sender = msg.sender; // address of the caller
        
    }
}