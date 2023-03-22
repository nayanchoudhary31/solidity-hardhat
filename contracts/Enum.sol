//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

// ENUMS ALLOW MORE MULTIPLE CHOICES
// ENUMS AS STATE VARIABLS
// ENUMS INSIDE STRUCT
// GET ENUMS SET ENUM & SET PARTICULAR ENUM

contract Enums {
    
    enum Status {
        NONE, // 0
        PENDING, // 1
        REJECTED, // 2
        SHIPPED, // 3
        COMPLETED, // 4
        CANCELED // 5
    }
    Status public status; // STATE VARIABLES

    // ENUMS INSIDE STRUCT
    struct Order {
        address buyer;
        Status status;
    }

    Order[] public orders;

    // FUNCTION TO GET STATUS
    function get() external view returns (Status _status) {
        _status = status;
        return _status;
    }

    // FUNCTION TO SET STATUS
    function set(Status _status) external {
        status = _status;
    }

    // FUNCTION TO UPDATE PARTICULAR
    function ship() external {
        status = Status.SHIPPED;
    }
}