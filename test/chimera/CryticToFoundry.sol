// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {ChimeraTargetFunctions} from "./ChimeraTargetFunctions.sol";
import {FoundryAsserts} from "lib/chimera/src/FoundryAsserts.sol";
import {Test, console2 as console} from "lib/forge-std/src/Test.sol";

// run from base project directory with:
// forge test --match-contract CryticToFoundry
// (if an invariant fails add -vvvvv on the end to see what failed)
//
// get coverage report (see https://medium.com/@rohanzarathustra/forge-coverage-overview-744d967e112f):

contract CryticToFoundry is Test, ChimeraTargetFunctions, FoundryAsserts {
    function setUp() public override {
        setup();
        super.setupLabels();
    }

    function testProperty() public {
        bool result = property_example();

        if (result) {
            console.log("True!");
        } else {
            console.log("False");
        }
    }

    // wrap every "property_*" invariant function into
    // a Foundry-style "invariant_*" function
    function invariant_example() public {
        assertTrue(property_example());
    }
}
