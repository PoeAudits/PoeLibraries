// SPDX-License-Identifier: GPL-2.0
pragma solidity ^0.8.0;

import {StdCheats, Test, console2 as console} from "lib/forge-std/src/Test.sol";
import "src/TestContract.sol";
import "test/PoeUtils/PoeUtils.sol";

contract Swap is Test, PoeUtils {
    TestContract internal swapper;

    address internal _alice = 0xDa9CE944a37d218c3302F6B82a094844C6ECEb17;

    function setUp() public {
        swapper = new TestContract();

        forkLocal();
        __PoeUtils_init();
    }

    function forkLocal() public {
        uint256 forkId = vm.createFork("http://127.0.0.1:8545");
        vm.selectFork(forkId);
    }
}
