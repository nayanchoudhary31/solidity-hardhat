// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

// self destruct delete the contract
// self destruct also send forcec ether to address
contract SelfDestruct {
    constructor() payable {}

    function kill() external {
        selfdestruct(payable(msg.sender));
    }

    function test() external pure returns (uint256) {
        return 123;
    }
}

contract Helper {
    function kill(SelfDestruct _kill) external {
        _kill.kill();
    }
}
