// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

contract FunctionSelector {
    event Log(bytes data);

    function transfer(address _from, uint256 _amount) external {
        emit Log(msg.data);
    }

    function getSelector(string calldata _text) external pure returns (bytes4) {
        return bytes4(keccak256(bytes(_text))); //
    }

    //0xa9059cbb -> Function Signature
    //00000000000000000000000078731d3ca6b7e34ac0f824c42a7cc18a495cabab
    //000000000000000000000000000000000000000000000000000000000000007b -> Amount in Hex
}
