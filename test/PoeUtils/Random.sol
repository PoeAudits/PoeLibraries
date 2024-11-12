// SPDX-License-Identifier: GPL-2.0
pragma solidity ^0.8.0;

import {console2 as console} from "lib/forge-std/src/Test.sol";
import {vm} from "test/PoeUtils/Recon/IHevm.sol";

abstract contract Random {
    uint256 random;

    ///@dev Hash of random number assumed to be random, especially after modulo operation
    ///@dev Used as deterministic randomness, allows reconstruction of random number from initial input
    function NewRandom() internal {
        random = uint256(keccak256(abi.encode(random)));
    }

    function UseRandom() internal returns (uint256 val) {
        val = random;
        NewRandom();
    }

    ///@dev Roll forward the blockchain a random amount of blocks
    ///@dev Assumed block time is 6 seconds
    function RandomRollForward(uint256 min, uint256 max) internal returns (uint256 forwardBlocks) {
        forwardBlocks = RandomBoundValue(min, max);
        console.log("Blocks Forward: ", forwardBlocks);
        vm.roll(block.number + forwardBlocks);
        vm.warp(block.timestamp + (6 * forwardBlocks));
        console.log("Block Number: ", block.number);
        console.log("");
    }

    ///@dev Return a random value between min and max
    function RandomBoundValue(uint256 min, uint256 max) internal returns (uint256 value) {
        require(max >= min, "Max is less than Min");
        value = (random % (max - min)) + min;
        console.log("Random Value: ", value);
        NewRandom();
    }
}
