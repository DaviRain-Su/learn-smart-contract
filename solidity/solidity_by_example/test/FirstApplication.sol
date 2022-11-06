// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/FirstApplication.sol";

contract FirstApplicationTest is Test {
    Counter public counter;

    function setUp() public {
        counter = new Counter();

    }

    function test_count_getter() public {
        assertEq(counter.count(), 0);
    }

    function test_inc() public {
        counter.inc();
        assertEq(counter.count(), 1);
    }

    function test_dec() public {
        counter.inc();
        counter.inc();
        assertEq(counter.count(), 2);
        counter.dec();
        assertEq(counter.count(), 1);
        counter.dec();
        assertEq(counter.count(), 0);
    }
}
