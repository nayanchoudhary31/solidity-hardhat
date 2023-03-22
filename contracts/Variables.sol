//SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

// State Variables Store The Data on The Blockchain Permanently (HARDISK)
contract StateVariables {
    uint256 public counter; // This is a State Variable

    function incrementCounter() external {
        counter += 1;
    }
}

// Local Variables are use inside the function and Function Execution is Done It Will Deleted
contract LocalVariables {
    function foo() external pure returns (uint256) {
        uint256 localVariable = 123; // This is a Local Variable It's scope is limited to function execution
        return localVariable;
    }
}

// Global Variables are provided data of blockchain msg.sender msg.value etc;
contract GlobalVariables {
    function getTimeStamp() external view returns (uint256) {
        return block.timestamp; // Return Current Block Time
    }

    function getCurrentCaller() external view returns (address) {
        return msg.sender; // Current Caller Address Global Variable
    }
}