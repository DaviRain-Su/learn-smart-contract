// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13; 

// Transactions are paid with ehter. 
// Similar to how one dollar is equal to 100 cent. one ether is equal to 10^18 wei.

contract EtherUints {
    uint public oneWei = 1 wei;
    // 1 wei is equal to 1
    bool public isOneWei = 1 wei == 1;

    uint public onEther = 1 ether;
    // 1 ehter is equal to 10^18 wei
    bool public isOneEther = 1 ether == 1e18;
}
