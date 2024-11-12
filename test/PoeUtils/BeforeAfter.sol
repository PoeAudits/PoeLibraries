// SPDX-License-Identifier: GPL-2.0
pragma solidity ^0.8.0;

// Delete HarnessState and add below after "make interface"
// import {HarnessState} from "test/harness/Harness.sol";

import {HarnessState} from "test/harness/Harness.sol";

abstract contract BeforeAfter {
    HarnessState internal _before;
    HarnessState internal _after;

    function __before(address user) internal virtual {}

    function __before() internal virtual {}

    function __after(address user) internal virtual {}

    function __after() internal virtual {}
}
