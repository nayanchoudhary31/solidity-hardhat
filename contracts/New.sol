// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

// 2 Ways to Deploy Contracts
// 1. CREATE
// 2. CREATE2
contract Accounts {
    address public owner;
    uint256 public number;

    constructor(uint256 _number) payable {
        number = _number;
        owner = msg.sender;
    }
}

contract AccountFactory {
    Accounts[] public deployedAddress;

    function deployAccount(uint256 number) public payable {
        Accounts a = new Accounts{value: msg.value}(number);
        deployedAddress.push(a);
    }
}
