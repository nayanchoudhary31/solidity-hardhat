// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

contract AccessControl {
    // Roles -> Account -> Bool
    mapping(bytes32 => mapping(address => bool)) public roles;

    //0xdf8b4c520ffe197c5343c6f5aec59570151ef9a492f2c624fd45ddde6135ec42
    bytes32 public constant ADMIN = keccak256(abi.encodePacked("ADMIN"));
    //0xaf290d8680820aad922855f39b306097b20e28774d6c1ad35a20325630c3a02c
    bytes32 public constant MANAGER = keccak256(abi.encodePacked("MANAGER"));

    event GrantRole(bytes32 indexed role, address indexed account);
    event RevokeRole(bytes32 indexed role, address indexed account);

    modifier onlyRole(bytes32 role) {
        require(roles[role][msg.sender] == true, "Unauthorized Admin");
        _;
    }

    constructor() {
        _grantRole(ADMIN, msg.sender);
    }

    function _grantRole(bytes32 _role, address _account) internal {
        roles[_role][_account] = true;
        emit GrantRole(_role, _account);
    }

    function _revokeRole(bytes32 _role, address _account) internal {
        roles[_role][_account] = false;
        emit RevokeRole(_role, _account);
    }

    function grantRole(bytes32 role, address account) external onlyRole(ADMIN) {
        require(account != address(0), "Invalid Account");
        _grantRole(role, account);
    }

    function revokeRole(
        bytes32 role,
        address account
    ) external onlyRole(ADMIN) {
        require(account != address(0), "Invalid Account");
        _revokeRole(role, account);
    }
}
