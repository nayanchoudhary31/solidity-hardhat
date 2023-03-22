//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

/***
    Bigger the No of Loop More Gas it Gonna Consume
 */
contract Loop {
    function loop() external pure {
        for (uint256 i = 0; i < 10; i++) {
            //code
            if (i == 3) {
                continue; // skip the current iteration
            }
            // code if i=3 this part will not execute
            if (i == 5) {
                break; // if i=5 we wil break
            }
        }
    }

    function sum(uint256 _n) external pure returns (uint256) {
        uint256 j = 1;
        uint256 s = 0;
        while (j <= _n) {
            s += j;
            j++;
        }
        return s;
    }
}
