// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

// Anyone can deposit the ETH & Only Owner Can Withdraw ETH

contract PiggyBank {
    event Deposit(address indexed account, uint256 indexed value);
    event Withdraw(address indexed owner, uint256 indexed amount);
    // To Receive Ether inside this contract

    address public owner = msg.sender;

    receive() external payable {
        emit Deposit(msg.sender, msg.value);
    }

    function withdraw() external {
        require(msg.sender == owner, "Only Owner");
        emit Withdraw(owner, address(this).balance);
        selfdestruct(payable(owner));
    }
}
