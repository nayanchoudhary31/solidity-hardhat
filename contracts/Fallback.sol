// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

// Fallback -> Execute when try to call a funciton which do not exists
// Mainly used for direct send ether

/*

    fallback() or recieve()

    Ether send to contract
             |
     is the msg.data is empty?
          /            \
        yes             no
 is receieve() exist?     fallback()
    /                         \
    receive()                  fallback() 
    

*/

contract Fallback {
    event Logs(string message, address caller, uint256 value);

    fallback() external payable {
        emit Logs("Fallback", msg.sender, msg.value);
    }

    receive() external payable {
        emit Logs("Receive", msg.sender, msg.value);
    }
}
