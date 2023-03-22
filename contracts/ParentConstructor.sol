//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

//Calling Parent Contract
// 2 Ways

contract S {
    string internal name;

    constructor(string memory _name) {
        name = _name;
    }
}

contract U {
    string internal text;

    constructor(string memory _text) {
        text = _text;
    }
}

// When we know the Input of the Parent Constructor
// contract T is S("S"), U("U") {

// }

// When we want to pass dynamic inputs to Parents Constructor
// NOTE:- We can use the both ways also
contract T is S, U("U") {
    constructor(string memory _name) S(_name) {}
}
