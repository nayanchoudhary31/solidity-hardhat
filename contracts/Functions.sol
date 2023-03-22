//SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

contract Function {
    function add(uint256 x, uint256 y) external pure returns(uint256 sum) {
        return sum = x+y;
    }

    function subtract(uint256 x, uint256 y) external pure returns(uint256 sub) {
        return sub =  x - y;
    }
}