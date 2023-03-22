//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

// Declare Mapping
// SET UPDATE DELETE GET
// NESTED MAPPING
// ["ALICE","BOB","NICK"]

contract Mapping {
    mapping(address => uint256) public balances; // NORMAL MAPPING
    mapping(address => mapping(uint256 => bool)) public isApproved; // NESTED MAPPING

    function foo() external {
        uint256 balance = balances[msg.sender]; // GET
        uint256 balance1 = balances[address(1)];
        balances[msg.sender] = 123; // SET
        balances[msg.sender] += 3000; // UPDATE
        delete balances[msg.sender]; // DELETE
    }
}
