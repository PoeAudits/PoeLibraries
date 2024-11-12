// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./Setup.sol";

contract TargetFunctions is Setup {
    function setUp() public virtual override {
        super.setUp();
    }

    function SelectUser() internal returns (address) {
        uint256 index = UseRandom() % users.length;
        return users[index];
    }
}
