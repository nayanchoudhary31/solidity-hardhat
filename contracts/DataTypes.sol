//SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

// There are 2 type of data types in solidity
// 1. Value (Which Hold the Data) (bool,uint256)
// 2. Reference (Which hold the reference to which data is store) (Arrays)

contract DataTypes {
    bool private isContract = true;

    uint256 public number; 
    // uint256 -> 0 to 2 ** 256-1
    // uint16 -> 0 to 2 **16-1
    // uint8 -> 0 to 2 ** 8-1
    int256 public number0; 
    // int256 -> - 2 ** 255 to 2 ** 255-1
    // int16 -> -2 ** 15 to 2 ** 15-1

    uint256 public uintMax = type(uint256).max;
    int256 public intMin = type(int256).min;

    address public owner = 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4;

    bytes32 private txHash =0xee69d429a6d38d550c6199a3f3811741ff3e71dfaafcb38a8856c9066f402f1c; // Use when deal with keccak256
}
