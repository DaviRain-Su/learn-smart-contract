// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

// Shadowing inerited state variables
// unlike function, state variable cannot be overridden by re-declaring it in the child contract.
// Let's learn how to correctly overrider inherited state variables.

contract A {
    string public name = "Contract A";

    function getName() public view returns (string memory) {
        return name;
    }
}

// Shadowing is disabllowed in Solidity 0.6
// This will not compile
// contract B is A {
//    string public name = "Contract B";
//}

contract C is A {
    // Tis ios the correct way to override inherited state variables.
    constructor() {
        name = "Contract C";
    }

    // C.getName returns "Contract C"
}