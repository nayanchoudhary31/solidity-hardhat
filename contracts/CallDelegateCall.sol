// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

contract A {
    uint256 public x;
    event X(address indexed caller, uint256 value);

    function setX(uint256 _x) public {
        x = _x;
        emit X(msg.sender, x);
    }
}

contract CallTest {
    function callSetX(address caller, uint256 _val) external {
        (bool ok, ) = caller.call(
            abi.encodeWithSignature("setX(uint256)", _val)
        );
        require(ok, "Call Failed");
    }
}

contract DelegateCall {
    uint256 public x;

    function callSetX(address caller, uint256 _val) external {
        (bool ok, ) = caller.delegatecall(
            abi.encodeWithSignature("setX(uint256)", _val)
        );
        require(ok, "Call Failed");
    }
}
