// SPDX-License-Identifier: GPL-2.0
pragma solidity ^0.8.0;

import {BeforeAfter, HarnessState} from "./BeforeAfter.sol";
import {Gas} from "./Gas.sol";
import {Log} from "./Log.sol";
import {Random} from "./Random.sol";

contract PoeUtils is Gas, Log, Random, BeforeAfter {
    function __PoeUtils_init() internal {
        __Gas_init();
    }
}
