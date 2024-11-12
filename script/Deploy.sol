// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "./BaseDeploy.sol";
import {DeploymentTemplate} from "./Deployments/DeploymentTemplate.s.sol";
import {DeployUniswapV3Lib} from "./Deployments/DeployUniswapV3Lib.s.sol";

contract Deploy is BaseDeploy {
    function setUp() public virtual override {
        super.setUp();
    }

    function run() public virtual {
        vm.startBroadcast();
        _target = deploy();
        vm.stopBroadcast();
    }
}
