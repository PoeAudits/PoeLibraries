// SPDX-License-Identifier: GPL-2.0
pragma solidity ^0.8.0;

import "../TargetFunctions.sol";

contract Init is TargetFunctions {
    function setUp() public override {
        super.setUp();
    }

    function testInit() public view {
        console.log("Deployment Address: ", _target);
        console.log("Stable Token: ", _depositToken);
    }
}
