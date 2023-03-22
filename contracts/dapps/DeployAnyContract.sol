//SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

// DEPLOY ANY ARBITARY CONTRACT USING BYTECODE
contract Factory {
    fallback() external payable {}

    event Deployed(address indexed contractAddr);

    // FUNCTION TO DEPLOY ANY ARBITARY  CONTRACT
    function deploy(bytes memory _code)
        external
        payable
        returns (address addr)
    {
        // CREATE(V,P,S)
        // V = AMOUNT OF ETHER TO SEND
        // P = POINTER IN MEMORY WHERE CODE START
        // S = SIZE OF CODE

        assembly {
            // callvalue -> msg.value
            // Skiping first 32 Bytes to Where Actual Code Start
            // Length of the Code in First 32 Bytes
            addr := create(callvalue(), add(_code, 0x20), mload(_code))
        }
        require(addr != address(0), "DEPLOYED FAILED");
        emit Deployed(addr);
    }

    // FUNCTION TO EXECUTE OR CALL THE CONTRACT
    function execute(address _target, bytes memory data) external payable {
        (bool ok, ) = _target.call{value: msg.value}(data);
        require(ok, "TX FAILED");
    }
}

contract TestContract1 {
    address public owner = msg.sender;

    function setOwner(address _newOwner) external {
        require(msg.sender == owner, "ONLY OWNER");
        owner = _newOwner;
    }
}

contract TestContract2 {
    address public owner = msg.sender;
    uint256 public values = msg.value;
    uint256 public x;
    uint256 public y;

    constructor(uint256 _x, uint256 _y) payable {
        x = _x;
        y = _y;
    }

    function setOwner(address _newOwner) external {
        require(msg.sender == owner, "ONLY OWNER");
        owner = _newOwner;
    }
}

// HELPER CONTRACT TO GET THE DATA & BYTECODE

contract Helper {
    function getBytecode1() external pure returns (bytes memory) {
        bytes memory bytecode = type(TestContract1).creationCode; // GET THE BYTECODE FROM TYPE CREATION CODE
        return bytecode;
    }

    function getBytecode2(uint256 _x, uint256 _y)
        external
        pure
        returns (bytes memory)
    {
        bytes memory bytecode = type(TestContract2).creationCode;
        return abi.encodePacked(bytecode, abi.encode(_x, _y)); // APPEND THE BYTECODE WITH INPUT USING ABI.ENCODEPACKED
    }

    function getData(address _owner) external pure returns (bytes memory) {
        return abi.encodeWithSignature("setOwner(address)", _owner);
    }
}
