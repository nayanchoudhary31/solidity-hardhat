//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

// ARRAY WE CAN TRACK BUT IN MAPPING WE CAN NOT TRACK DATA
// WILL CREATED ITERABLE MAPPING WITH FOLLOWING MAPS

contract IterableMapping {
    mapping(address => uint256) public balances;
    mapping(address => bool) public isInserted;
    address[] public keys;

    function set(address _key, uint256 _values) external {
        balances[_key] += _values;
        if (!isInserted[_key]) {
            keys.push(_key);
            isInserted[_key] = true;
        }
    }

    // FUNCTION TO GET FIRST KEY BALANCE IN MAP
    function getFirst() external view returns (uint256) {
        return balances[keys[0]];
    }

    // FUNCTION TO GET LAST KEY BALANCE IN MAP
    function getLast() external view returns (uint256) {
        return balances[keys[keys.length - 1]];
    }
}
