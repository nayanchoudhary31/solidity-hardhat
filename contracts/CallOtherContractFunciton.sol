// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

contract CallingContract {
    function setTestX(TestContract test, uint256 x) external {
        test.setX(x);
    }

    function getXTest(TestContract test) external view returns (uint256) {
        uint256 x = test.getX();
        return x;
    }

    function setXAndSendETH(TestContract test, uint256 _x) external payable {
        test.setXAndReceiveETH{value: msg.value}(_x);
    }

    function getXAndValue(
        TestContract test
    ) external view returns (uint256, uint256) {
        (uint256 x, uint256 amount) = test.getXAndValue();
        return (x, amount);
    }
}

contract TestContract {
    uint256 public x;
    uint256 public value = 123;

    function setX(uint256 _x) external {
        x = _x;
    }

    function getX() external view returns (uint256) {
        return x;
    }

    function setXAndReceiveETH(uint256 _x) external payable {
        x = _x;
        value = msg.value;
    }

    function getXAndValue() external view returns (uint256, uint256) {
        return (x, value);
    }
}
