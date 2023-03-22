//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

// Reuse the Code Before & After Functions
// Basic Input Sandwich

contract FunctionModifier {
    bool public isPaused;
    uint256 public count;
    address public owner;

    modifier paused() {
        require(!isPaused, "Contract Paused");
        _;
    }

    function setPaused() external {
        isPaused = !isPaused;
    }

    function increment() external paused {
        // require(!paused,"Contract Paused"); Code Repeat
        count += 1;
    }

    function decrement() external paused {
        // require(!paused,"Contract Paused"); // Code Repeat
        count -= 1;
    }

    modifier capCount(uint256 x) {
        require(x < 100, "X > 100");
        _;
    }

    function incrementCount(uint256 x) external paused capCount(x) {
        // require(x < 100,"X Greater 100");
        count += x;
    }

    modifier sandwich() {
        // Code More // This part will execute in modifier Before
        count += 10; // Increment the Count
        _; // Call The Function // More Code execute in Function
        count *= 2; // Will Execute in the Modifer
        //More Code
    }

    function foo() external sandwich {
        count += 1;
    }
}