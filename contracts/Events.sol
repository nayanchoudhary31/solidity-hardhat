//SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

// Upto 3 Parameters can be Indexed

contract Events {
    event Log(address caller, uint256 num);
    event IndexedLog(string indexed message);

    event Message(
        address indexed from,
        address indexed to,
        string indexed message
    );

    function example() external {
        emit Log(msg.sender, 785);
        emit IndexedLog("Indexed Log: Hello");
    }

    function sendMessage(address _to, string calldata message) external {
        emit Message(msg.sender, _to, message);
    }
}
