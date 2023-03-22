//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

contract IfElse {
    function boo(uint256 a) external pure returns (uint256) {
        if (a < 10) {
            return 10;
        } else if (a > 10) {
            return 20;
        }
        return 0;
    }

    function ternaryOp(uint256 a) external pure returns (uint256) {
        return a > 10 ? 20 : 10;
    }
}
