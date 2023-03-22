//SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

// Use Virtual so Child Contract Can Override & Modify Functionality

contract A {
    function boo() external pure virtual returns (string memory) {
        return "BOO:->A";
    }

    function foo() external pure virtual returns (string memory) {
        return "FOO:->A";
    }

    // More Code

    function baaz() external pure returns (string memory) {
        return "BAAZ:-> A";
    }
}

contract B is A {
    function boo() external pure override returns (string memory) {
        return "BOO:->B";
    }

    function foo() external pure override returns (string memory) {
        return "FOO:->B";
    }

    function bar() external pure virtual returns (string memory) {
        return "BAR:-> B";
    }
}

contract C is B {
    function bar() external pure override returns (string memory) {
        return "BAR:-> C";
    }
}
