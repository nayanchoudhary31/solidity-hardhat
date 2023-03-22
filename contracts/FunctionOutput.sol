//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

contract FunctionOutputs {
    function returnMany() public pure returns (uint256, bool) {
        return (1, true);
    }

    // Named Returns Functions
    function namedReturn() public pure returns (uint256 x, bool y) {
        return (1, true);
    }

    //Assigned Returns
    function destructureAssignment() public pure returns (uint256 x, bool y) {
        x = 1;
        y = false;
    }

    function foo() public pure returns (uint256 x, bool y) {
        (x, y) = returnMany(); // Destructing Assignment
        (, y) = returnMany(); // Omit The Values Also
        return (x, y);
    }
}
