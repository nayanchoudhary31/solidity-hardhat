//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

// 3 Ways to Throw Erro
// 1. Require  2.Revert  3.Assert
//Gas Refund , any state update will revert
// From 0.8 we can have the custome error

contract Errors {

    function testRequire(uint256 i) external pure {
        require(i<=10,"I Greater than 10");
        // If True then only code execute
    }

       function testRevert(uint256 i) external pure {
        if (i > 1) {
            if (i > 5) {
                if (i > 10) {
                    revert("I > 10"); // Can be useful in nested condition
                }
            }
        }
    }

    // Assert we use when we know the condition will always be true if false buggy smart contract
    uint256 public num = 123;

    function testAssert() external view {
        assert(num == 123); // Will always be true if there is no way to update the num 
    }

    // We can have Custom Error From sol 0.8.0 
    // Can be use to save gas
    

    error MyError(address caller,uint256 val);


    function testCustomError(uint256 x) external view {
        if(x>20){
            revert MyError(msg.sender,x);
        }
    }


}