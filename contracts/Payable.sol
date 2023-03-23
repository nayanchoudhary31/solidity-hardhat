// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

// Payable give functionality to send and receive ether
contract Payable {
    address payable public owner;

    constructor() {
        owner = payable(msg.sender);
    }

    function deposit() external payable {}

    function getBalance() external view returns (uint256) {
        return address(this).balance;
    }
}
