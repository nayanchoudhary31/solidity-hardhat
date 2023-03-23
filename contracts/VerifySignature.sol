// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

// Get Messsage
// Hash (Message)
// Sign (hash(message),Private-key) -> Signature
// Verify Signature ecrecover hash(message),sig)

contract VerifySig {
    string public constant prefix = "\x19Ethereum Signed Message:\n32";

    function verfiy(
        address signer,
        string memory text,
        bytes memory sig
    ) external pure returns (bool) {
        bytes32 messageHash = getHashed(text); // Get The Hashed Message
        bytes32 ethHashedMessage = getEthHashed(messageHash); // Hash Again to Get ETH Hashed Message (Add Prefix + Hashed Message)
        return (isValidSigner(ethHashedMessage, sig) == signer);
    }

    function getHashed(string memory _text) public pure returns (bytes32) {
        return (keccak256(abi.encodePacked(_text)));
    }

    function getEthHashed(bytes32 _hashMessage)
        public
        pure
        returns (bytes32)
    {
        return keccak256(abi.encodePacked(prefix, _hashMessage));
    }

    function isValidSigner(bytes32 _hashMessage, bytes memory sig)
        public
        pure
        returns (address)
    {
        (uint8 v, bytes32 r, bytes32 s) = splitSignature(sig); // Split the Signature
        // r and s are for cryptographic pramas for digital signature & v is unique for eth
        return ecrecover(_hashMessage, v, r, s);
    }

    /*
     *  NOTE:- Sig is dynamic datatype that's why first 32 bytes are for data length
     * Sig is a not the actual signature but it is pointer where actual signature is store
     */

    function splitSignature(bytes memory sig)
        internal
        pure
        returns (
            uint8 v,
            bytes32 r,
            bytes32 s
        )
    {
        require(sig.length == 65, "Invalid Signature");
        assembly {
            r := mload(add(sig, 32)) // Skip First 32 Bytes to get R Value (First 32 Bytes -> Array Length)
            s := mload(add(sig, 64)) // Skip First 64 Bytes to get S Value
            v := byte(0, mload(add(sig, 96))) // Skip First 96 Bytes & Need Only First Bytes to Get V Value
        }
    }
}