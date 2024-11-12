//SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.4;

import "lib/v3-periphery/contracts/interfaces/ISwapRouter.sol";
import {SafeERC20, IERC20} from "lib/openzeppelin-contracts/contracts/token/ERC20/utils/SafeERC20.sol";

struct SwapConfig {
    address router;
    address baseToken;
    mapping(address => mapping(address => uint24)) fee;
    mapping(address => uint256) minAmount;
}

///@notice Library to use UniswapV3 swap functions
///@dev Does not pollute storage of contracts using this library
library UniswapV3Lib {
    using SafeERC20 for IERC20;

    ///@notice Set fee for token pair
    ///@dev Sets fee for both directions
    ///@param self The SwapConfig of the inheriting contract
    ///@param _from The address of the token being swapped
    ///@param _to The address of the desired token
    ///@param _fee The fee set by the pool for swaps
    function setFee(
        SwapConfig storage self,
        address _from,
        address _to,
        uint24 _fee
    ) internal {
        self.fee[_from][_to] = _fee;
        self.fee[_to][_from] = _fee;
    }

    ///@notice Sets the minimum amount for a token to be swapped
    ///@dev The minAmount is used to prevent swaps with dust amounts of tokens
    ///@dev The default value 0 will not cause an error
    ///@param self The SwapConfig of the inheriting contract
    ///@param _from The address of the token being swapped
    ///@param _amount The amount required before _from can be swapped
    function setMinAmount(
        SwapConfig storage self,
        address _from,
        uint256 _amount
    ) internal {
        self.minAmount[_from] = _amount;
    }

    ///@notice Swaps `amountIn` of one token for as much as possible of another token
    ///@param self The SwapConfig of the inheriting contract
    ///@param _from The address of the token being swapped
    ///@param _to The address of the desired token
    ///@param _amountIn The amount out of the desired token
    ///@param _minAmountOut The maximum amount of _from to spend
    function swapExactInput(
        SwapConfig storage self,
        address _from,
        address _to,
        uint256 _amountIn,
        uint256 _minAmountOut
    ) internal returns (uint256 out) {
        if (_amountIn >= self.minAmount[_from]) {
            _checkAllowance(self.router, _from, _amountIn);
            if (_from == self.baseToken || _to == self.baseToken) {
                out = ISwapRouter(self.router).exactInputSingle(
                    ISwapRouter.ExactInputSingleParams(
                        _from,
                        _to,
                        self.fee[_from][_to],
                        address(this),
                        block.timestamp,
                        _amountIn,
                        _minAmountOut,
                        0
                    )
                );
            } else {
                bytes memory path = abi.encodePacked(
                    _from,
                    self.fee[_from][self.baseToken],
                    self.baseToken,
                    self.fee[self.baseToken][_to],
                    _to
                );

                out = ISwapRouter(self.router).exactInput(
                    ISwapRouter.ExactInputParams(
                        path,
                        address(this),
                        block.timestamp,
                        _amountIn,
                        _minAmountOut
                    )
                );
            }
        }
    }

    ///@notice Swaps as little as possible of one token for `amountOut` of another token
    ///@param self The SwapConfig of the inheriting contract
    ///@param _from The address of the token being swapped
    ///@param _to The address of the desired token
    ///@param _amountOut The amount out of the desired token
    ///@param _maxAmountIn The maximum amount of _from to spend
    function swapExactOutput(
        SwapConfig storage self,
        address _from,
        address _to,
        uint256 _amountOut,
        uint256 _maxAmountIn
    ) internal returns (uint256 out) {
        if (_maxAmountIn >= self.minAmount[_from]) {
            _checkAllowance(self.router, _from, _maxAmountIn);
            if (_from == self.baseToken || _to == self.baseToken) {
                out = ISwapRouter(self.router).exactOutputSingle(
                    ISwapRouter.ExactOutputSingleParams(
                        _from,
                        _to,
                        self.fee[_from][_to],
                        address(this),
                        block.timestamp,
                        _amountOut,
                        _maxAmountIn,
                        0
                    )
                );
            } else {
                bytes memory path = abi.encodePacked(
                    _from,
                    self.fee[_from][self.baseToken],
                    self.baseToken,
                    self.fee[self.baseToken][_to],
                    _to
                );

                out = ISwapRouter(self.router).exactOutput(
                    ISwapRouter.ExactOutputParams(
                        path,
                        address(this),
                        block.timestamp,
                        _amountOut,
                        _maxAmountIn
                    )
                );
            }
        }
    }

    ///@notice Check if the allowance given to router contract is sufficient
    ///@dev If it is not sufficient, set the allowance to _amount
    ///@param _router The router contract address
    ///@param _from The token being spent
    ///@param _amount The amount of the token/allowance to be spent/given
    function _checkAllowance(
        address _router,
        address _from,
        uint256 _amount
    ) internal {
        if (IERC20(_from).allowance(address(this), _router) < _amount) {
            SafeERC20.safeIncreaseAllowance(IERC20(_from), _router, _amount);
        }
    }
}
