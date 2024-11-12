// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import {ChimeraTargetFunctions} from "./ChimeraTargetFunctions.sol";
import {CryticAsserts} from "lib/chimera/src/CryticAsserts.sol";

// configure solc-select to use compiler version:
// solc-select install 0.8.23
// solc-select use 0.8.23
//
// run from base project directory with:
// echidna . --contract targetCryticTester --config echidna.yaml
// medusa --config medusa.json fuzz
contract CryticTester is ChimeraTargetFunctions, CryticAsserts {
    constructor() payable {
        setup();
    }
}
