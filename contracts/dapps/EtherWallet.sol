// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

contract EtherWallet {
    address payable public owner;
    event Received(uint256 value);

    constructor() {
        owner = payable(msg.sender);
    }

    receive() external payable {
        emit Received(msg.value);
    }

    function withdraw() external {
        require(msg.sender == owner, "Only Owner");
        (bool ok, ) = owner.call{value: address(this).balance}("");
        require(ok, "Tx Failed");
    }

    function getBalance() external view returns (uint256) {
        return address(this).balance;
    }
}
