// SPDX-License-Identifier: GPL-2.0
pragma solidity ^0.8.0;

import {ChimeraSetup, console} from "./ChimeraSetup.sol";
import {Asserts} from "lib/chimera/src/Asserts.sol";

import {BeforeAfter} from "test/PoeUtils/BeforeAfter.sol";

abstract contract ChimeraProperties is ChimeraSetup, Asserts {
    ///@dev Use prefix property_ for invariant functions, and return false if broken
    function property_example() public view returns (bool result) {
        return true;
    }
}
