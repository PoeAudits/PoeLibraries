// SPDX-License-Identifier: GPL-2.0
pragma solidity ^0.8.0;

import {ChimeraProperties} from "./ChimeraProperties.sol";
import "./ChimeraSetup.sol";
import {BaseTargetFunctions} from "lib/chimera/src/BaseTargetFunctions.sol";
import {IHevm, vm} from "lib/chimera/src/Hevm.sol";

abstract contract ChimeraTargetFunctions is
    BaseTargetFunctions,
    ChimeraProperties
{
    function handler_example(uint256 userIndex) external {
        // get an index into the recipients array to randomly
        // select a valid recipient
        //
        // note: using `between` provided by Chimera instead of
        // Foundry's `bound` for cross-fuzzer compatibility
        userIndex = between(userIndex, 0, users.length - 1);

        address user = users[userIndex];

        __before(user);
        // note: using `vm` from Chimera's IHevm
        // for cross-fuzzer cheatcode compatibility
        vm.prank(user);
        target.GetState(user);
        __after(user);

        eq(_before.TBD, _after.TBD, "Handler Example Error TBD");
    }
}
