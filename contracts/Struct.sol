//SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.0;

// STRUCTS ALLOW TO GROUP USER DATA
// STRCUTS AS STATE VARIABLE | AS ARRAY | AS MAPPING

contract Structs {
    struct Car {
        address owner;
        uint256 price;
        string model;
    }

    Car public car; // STATE VARIABLE
    Car[] public cars; // ARRAY
    mapping(address => Car[]) public carByOwner; // MAP

    function foo() external {
        // THREE WAY TO INITIALIZE STRUCT
        Car memory c1 = Car(msg.sender, 500, "CRETA"); // 1ST WAY
        Car memory c2 = Car({model: "THAR", price: 700, owner: msg.sender}); // 2ND WAY
        Car memory c3;
        c3.owner = msg.sender; // 3RD WAY
        c3.price = 900; // 3RD WAY
        c3.model = "Lamborghini"; // 3RD WAY

        // SET STRUCT IN STATE VARIABLE IN THIS CASE ARRAY
        cars.push(c1);
        cars.push(c2);
        cars.push(c3);
        cars.push(Car(msg.sender, 700, "VERNA"));

        // UPDATE
        Car storage _c1 = cars[0];
        _c1.model = "LAND ROVER";
        delete _c1.model;

        delete cars[0];
    }
}
