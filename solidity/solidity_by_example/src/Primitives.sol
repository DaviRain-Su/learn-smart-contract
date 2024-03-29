// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

// Here we introduce you to some primitive data type avaliable in Solidity.
contract Primitives {
    bool public boo = true;

    /*
    uint stands for unsigned integer. meaning non negative integers
    different sizes are available
        uint8 ranges from 0 to 2 ** 8 - 1
        uint16 ranges from 0 to 2 ** 16 -1
        ... 
        uint256 ranges from 0 to 2 ** 256 - 1
    */
    uint8 public u8 = 1;
    uint public u256 = 456;
    uint public u = 123; // uint is alias for uint256 and

    /*
    Negative number are allowed for in types. 
    Like uint, different ranges are available from int8 to int256.

    int256 ranges from -2 ** 255 to 2 ** 255 - 1
    int128 ranges from -2 ** 127 to 2 ** 127 - 1
    */
    int8 public i8  = -1;
    int public i256 = 456;
    int public i = -123; // int is same as int256

    // minimu and maximum of int
    int public minInt = type(int).min;
    int public maxInt = type(int).max;

    address public addr = 0xCA35b7d915458EF540aDe6068dFe2F44E8fa733c;

    /*
    In Solidity, the data type bytes represent a sequence of bytes. 
    Solidity presents two type of bytes types
    - fixed-sized byte arrays
    - dynamically-sized byte arrays.

    This term bytes in Solidity represents a dynamic array of bytes.
    It's a shorthand for bytes[].
    */
   bytes1 public a = 0xb5; // [10110101]
   bytes1 public b = 0x56; // [01010110]

    // Default values
    // Unassigned variables have a default value
    bool public defaultBoo; // false
    uint public defaultUint; // 0
    int public defaultInt; // 0
    address public defaultAddr; // 0x0000000000000000000000000000000000000000
}