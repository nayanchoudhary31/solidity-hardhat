//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

// Arrays -> Dynamic or Fixed Size
// Initialize
// Insert(push),Get,Update,Delete,Pop,Length
// Create Arrays in Memory
// Returns Arrays from Functions

contract Arrays {
    uint256[] public nums = [1, 2, 3]; // Dynamic Array
    // uint256[4] public fixedArray = [1,2,3,4,5] // Size is 4 and element is Five Error
    uint256[5] public fixedArray = [1, 2, 3, 4, 5];

    function foo() external {
        nums.push(4); // Insert [1,2,3,4]
        uint256 x = nums[1]; // Get By Index [2]
        nums[2] = 56; // [1,2,56,4];
        delete nums[2]; // [1,2,0,4]
        nums.pop(); // [1,2,0];

        //Only can create Fixed Size Array in Memory
        uint256[] memory arr = new uint256[](5);
        arr[2] = 123;

        // Can not use Push & Pop with Memory Arrays
        // arr.push(123); //ERROR
        // arr.pop() // ERROR
    }

    function getNums() external view returns (uint256[] memory) {
        return nums;
    }
}
