// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

contract Keccak256 {

    function hash(string memory text,uint256 _number,address addr) external pure returns(bytes32){
        return keccak256(abi.encode(text,_number,addr));
    }

    function encodePacked(string memory text0,string memory text1) external pure returns(bytes memory){
        return abi.encodePacked(text0,text1);
    }

    function encode(string memory text0,string memory text1) external pure returns(bytes memory){
        return abi.encode(text0,text1);
    }
}