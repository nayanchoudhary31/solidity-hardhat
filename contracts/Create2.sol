//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

/// Create2 Allow us to precompute address before deploying contract
contract DeployWithCreate2 {
    address public owner;

    constructor(address _owner) {
        owner = _owner;
    }
}

/**
 * @title Create2 Factory
 * @author iamnayan31
 */
contract Create2Factory {
    event Deployed(address indexed contractAddress);

    /**
     * @notice Deploy the contract using Create Method
     */

    function deployWithCreate() external {
        DeployWithCreate2 d = new DeployWithCreate2(msg.sender);
        emit Deployed(address(d));
    }

    /**
     * @notice Deploy contract using Create2 using Salt
     */

    function deployWithCreate2(uint256 _salt) external {
        DeployWithCreate2 d = new DeployWithCreate2{salt: bytes32(_salt)}(
            msg.sender
        );
        emit Deployed(address(d));
    }

    /// new_address = hash(0xFF, sender, salt, bytecode)
    /**
     * @notice Predetermine hash using bytecode and salt
     */

    function getAddress(bytes memory _bytecode, uint256 _salt)
        external
        view
        returns (address)
    {
        bytes32 hash = keccak256(
            abi.encodePacked(
                bytes1(0xff),
                address(this),
                _salt,
                keccak256(_bytecode)
            )
        );

        return address(uint160(uint256(hash))); // Last 20 Bytes will be address
    }

    /**
     * @notice Get the Bytecode of the Contract
     * @param _owner Constructor Args Owner
     */

    function getBytecode(address _owner) external pure returns (bytes memory) {
        bytes memory bytecode = type(DeployWithCreate2).creationCode;
        return abi.encodePacked(bytecode, abi.encode(_owner));
    }
}

// Precompute Address 0x018aDEA090Be7aDB4B2234c6278A8E99102F6111
// Create 0xd840735F4B6a0d1AF8Fa48EcE560f4778c007397
// Create2 Address 0x018aDEA090Be7aDB4B2234c6278A8E99102F6111