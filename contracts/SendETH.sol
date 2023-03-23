// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

// 3 Ways to Send Ether
// transfer 2300 gas revert
// send 2300 gas bool
// call all gas and return bool & data

contract SendETH {
    constructor() payable {}

    receive() external payable {}

    // Gas 2258
    function sendviaTransfer(address payable _to) external payable {
        _to.transfer(123);
    }

    // Gas 2258
    function sendViaSend(address payable _to) external payable {
        bool ok = _to.send(123);
        require(ok, "TX Failed");
    }

    // Gas 6561
    function sendViaCall(address payable _to) external payable {
        (bool ok, ) = _to.call{value: 123}("");
        require(ok, "TX Failed");
    }
}

contract ETHReceiver {
    event Logs(address caller, uint256 value, uint256 gas);

    receive() external payable {
        emit Logs(msg.sender, msg.value, gasleft());
    }
}
