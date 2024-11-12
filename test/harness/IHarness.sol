// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.4;
import {HarnessState} from "test/harness/Harness.sol";

interface IHarness {

    error SafeERC20FailedOperation(address token);

    function GetState() external view returns (HarnessState memory self);
    function GetState(address user) external view returns (HarnessState memory self);
    function deposit(address token, uint256 amount) external;
    function setFee(address _have, address _want, uint24 _fee) external;
    function swapExactInput(address _from, address _to, uint256 _amountIn, uint256 _minAmountOut)
        external
        returns (uint256 out);
    function swapExactOutput(address _from, address _to, uint256 _amountOut, uint256 _maxAmountIn)
        external
        returns (uint256 out);
}
