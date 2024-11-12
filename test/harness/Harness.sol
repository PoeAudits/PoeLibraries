//SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "src/TestContract.sol";

struct HarnessState {
    uint256 TBD;
}

contract Harness is TestContract {
    constructor() {}

    function GetState() external view returns (HarnessState memory self) {}

    function GetState(
        address user
    ) external view returns (HarnessState memory self) {}
}
