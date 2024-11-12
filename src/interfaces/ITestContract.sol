// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.4;

interface ITestContract {
    error SafeERC20FailedOperation(address token);

    function deposit(address token, uint256 amount) external;
    function setFee(address _have, address _want, uint24 _fee) external;
    function swapExactInput(address _from, address _to, uint256 _amountIn, uint256 _minAmountOut)
        external
        returns (uint256 out);
    function swapExactOutput(address _from, address _to, uint256 _amountOut, uint256 _maxAmountIn)
        external
        returns (uint256 out);
}
