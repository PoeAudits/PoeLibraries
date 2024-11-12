// // SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "../Setup.sol";

import {BaseSetup} from "lib/chimera/src/BaseSetup.sol";
import {IHevm, vm} from "lib/chimera/src/Hevm.sol";
import "test/PoeUtils/PoeUtils.sol";

contract ChimeraSetup is BaseSetup, Setup {
    ///@dev Overriding setUp to prevent double setUp
    function setUp() public virtual override {}

    function setup() internal virtual override {
        isChimera = true;
        Setup.setUp();
    }

    function setupUsers() internal virtual override {
        users.push(address(0x11111));
        users.push(address(0x22222));
        users.push(address(0x33333));
    }
}
