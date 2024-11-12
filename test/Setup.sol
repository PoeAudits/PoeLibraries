// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {StdCheats, Test, console2 as console} from "lib/forge-std/src/Test.sol";

import "script/Deploy.sol";
import "test/PoeUtils/PoeUtils.sol";

contract Setup is Test, PoeUtils, DeployUniswapV3Lib {
    bool isChimera = false;

    mapping(address => string) names;

    ///@dev If testing with chimera, no forking and no labels
    modifier SetupChimera() {
        if (!isChimera) {
            forkLocal();
        }
        _;
        if (!isChimera) {
            setupLabels();
        }
    }

    function setUp() public virtual override SetupChimera {
        setupUsers();
        super.setUp();
        setupNames();
        __PoeUtils_init();
    }

    function forkLocal() public {
        uint256 forkId = vm.createFork("http://127.0.0.1:8545");
        vm.selectFork(forkId);
    }

    ///@notice Setup contract labels
    function setupLabels() internal {
        vm.label(_depositToken, "Deposit Token");
        vm.label(_target, "Implementation");
        vm.label(_alice, "Alice");
        vm.label(_bob, "Bob");
        vm.label(_carl, "Carl");
    }

    ///@notice Setup names array
    ///@dev Useful for logging contract names during debugging
    function setupNames() internal {
        names[_depositToken] = "Deposit Token";
        names[_target] = "Target";
        names[_alice] = "Alice";
        names[_bob] = "Bob";
        names[_carl] = "Carl";
    }

    ///@notice Setup users
    ///@dev Funding logic in parent contract
    function setupUsers() internal virtual {
        users.push(_alice);
        users.push(_bob);
        users.push(_carl);
    }

    ///@dev Setup BeforeAfter functions to use Harness GetState functions
    ///@dev After running "make interface" need to remove state struct from IHarness and import it from Harness
    ///@dev import {State} from "test/harness/Harness.sol";
    function __before(address user) internal virtual override {
        _before = target.GetState(user);
    }

    function __after(address user) internal virtual override {
        _after = target.GetState(user);
    }

    function __before() internal virtual override {
        _before = target.GetState();
    }

    function __after() internal virtual override {
        _after = target.GetState();
    }
}
