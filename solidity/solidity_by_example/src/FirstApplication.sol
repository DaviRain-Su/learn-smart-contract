// SPDX-License-Identifier: MIT 
pragma solidity ^0.8.13;

// Here is a simple contract that you can get, 
// increment and decrement the count store in this contract.
contract Counter {
    uint public count; 

    // Function to get the current count of the counter
    function get() public view returns (uint) {
        return count;
    }

    // Function to increment count by 1
    function inc() public {
        count += 1;
    }

    // Founction to decrement count by 1
    function dec() public {
        // This function is will fail if count = 0
        require(count != 0, "Can't decrement count, because count is zero");

        count -= 1;
    }
}