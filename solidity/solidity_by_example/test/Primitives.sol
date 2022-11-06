// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import "../src/Primitives.sol";

contract PrimitivesTest is Test {
    Primitives public primitives;

    function setUp() public {
        primitives = new Primitives();
    }

    function test_primitives() public {
        assertEq(primitives.boo(), true);
        assertEq(primitives.u8(), 1);
        assertEq(primitives.u256(), 456);
        assertEq(primitives.u(), 123);
        assertEq(primitives.i8(), -1);
        assertEq(primitives.i256(), 456);
        assertEq(primitives.i(), -123);
        assertEq(primitives.minInt(), type(int).min);
        assertEq(primitives.maxInt(), type(int).max);
        assertEq(primitives.addr(), 0xCA35b7d915458EF540aDe6068dFe2F44E8fa733c);
        // assertEq(primitives.a(), 0xb5);
        // assertEq(primitives.b(), 0x56);
        assertEq(primitives.defaultBoo(), false);
        assertEq(primitives.defaultUint(), 0);
        assertEq(primitives.defaultInt(), 0);
        assertEq(primitives.defaultAddr(), 0x0000000000000000000000000000000000000000);
    }
}
