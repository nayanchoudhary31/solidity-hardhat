//SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

// Funciton which does not modify the state can be declared as View or Pure Funcitons

// View Function are just read only function which does not cost gas and use state variables
contract ViewFunciton {
    address private owner = msg.sender;

    function getOwner() external view returns(address) {
        return owner;
    }
}


// Pure Functions are also read only and not cost gas but it wont use any state variables 
contract PureFunction {

    function addNumber(uint256 x,uint256 y) external pure returns(uint256){
        return x + y;
    }
}