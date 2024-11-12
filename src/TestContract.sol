//SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "src/libraries/UniswapV3Lib.sol";

contract TestContract {
    using UniswapV3Lib for SwapConfig;
    using SafeERC20 for IERC20;

    SwapConfig internal swapConfig;

    constructor() {
        /*´:°•.°+.*•´.*:˚.°*.˚•´.°:°•.°•.*•´.*:˚.°*.˚•´.°:°•.°+.*•´.*:*/
        /*                      UniswapV3Lib Setup                    */
        /*.•°:°.´+˚.*°.˚:*.´•*.+°.•°:´*.´•*.•°.•°:°.´:•˚°.*°.˚:*.´+°.•*/
        swapConfig.router = 0xE592427A0AEce92De3Edee1F18E0157C05861564;
        swapConfig.baseToken = 0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48;

        swapConfig.setFee(
            swapConfig.baseToken,
            0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2,
            500
        );
        /*´:°•.°+.*•´.*:˚.°*.˚•´.°:°•.°•.*•´.*:˚.°*.˚•´.°:°•.°+.*•´.*:*/
        /*                                                            */
        /*.•°:°.´+˚.*°.˚:*.´•*.+°.•°:´*.´•*.•°.•°:°.´:•˚°.*°.˚:*.´+°.•*/
    }

    function deposit(address token, uint256 amount) external {
        IERC20(token).safeTransferFrom(msg.sender, address(this), amount);
    }

    /*´:°•.°+.*•´.*:˚.°*.˚•´.°:°•.°•.*•´.*:˚.°*.˚•´.°:°•.°+.*•´.*:*/
    /*                   UniswapV3Lib Functions                   */
    /*.•°:°.´+˚.*°.˚:*.´•*.+°.•°:´*.´•*.•°.•°:°.´:•˚°.*°.˚:*.´+°.•*/
    function setFee(address _have, address _want, uint24 _fee) external {
        swapConfig.setFee(_have, _want, _fee);
    }

    function swapExactInput(
        address _from,
        address _to,
        uint256 _amountIn,
        uint256 _minAmountOut
    ) external returns (uint256 out) {
        return swapConfig.swapExactInput(_from, _to, _amountIn, _minAmountOut);
    }

    function swapExactOutput(
        address _from,
        address _to,
        uint256 _amountOut,
        uint256 _maxAmountIn
    ) external returns (uint256 out) {
        return swapConfig.swapExactOutput(_from, _to, _amountOut, _maxAmountIn);
    }

    /*´:°•.°+.*•´.*:˚.°*.˚•´.°:°•.°•.*•´.*:˚.°*.˚•´.°:°•.°+.*•´.*:*/
    /*                    Functions                               */
    /*.•°:°.´+˚.*°.˚:*.´•*.+°.•°:´*.´•*.•°.•°:°.´:•˚°.*°.˚:*.´+°.•*/
}
