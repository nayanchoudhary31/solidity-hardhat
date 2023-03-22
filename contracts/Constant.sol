//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

// Gas -> 21420
contract Constant {
    address public constant owner = 0x5B38Da6a701c568545dCfcB03FcB875f56beddC4;
}

// Gas -> 23553
contract NonConstant {
    address public nonConstantOwner =0x5B38Da6a701c568545dCfcB03FcB875f56beddC4;
}
