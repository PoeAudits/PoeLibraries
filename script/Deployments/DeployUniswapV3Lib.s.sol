// SPDX-License-Identifier: UNLICENSED

pragma solidity 0.8.20;

import "../BaseDeploy.sol";

contract DeployUniswapV3Lib is BaseDeploy {
    ///@dev 10th Anvil generated addresses
    address internal _admin = 0xa0Ee7A142d267C1f36714E4a8F75612F20a79720;

    IERC20 internal depositToken;
    address internal _depositToken;

    uint256 internal depositTokenDecimals;

    ///@dev Transfering from existing wallets seems to work most reliably
    address internal _depositTokenWhale;

    IERC20 internal usdc;
    IERC20 internal weth;
    IERC20 internal wbtc;
    IERC20 internal uni;
    address internal _usdc = 0xA0b86991c6218b36c1d19D4a2e9Eb0cE3606eB48;
    address internal _weth = 0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2;
    address internal _wbtc = 0x2260FAC5E5542a773Aa44fBCfeDf7C193bc2C599;
    address internal _uni = 0x1f9840a85d5aF5bf1D1762F925BDADdC4201F984;

    ///@dev Using standard amount to avoid tests breaking on decimal changes
    uint256 standardAmount;

    function setUp() public virtual override {
        // USDC on Eth Main
        _depositToken = _usdc;
        depositToken = IERC20(_depositToken);
        usdc = IERC20(_usdc);
        weth = IERC20(_weth);
        wbtc = IERC20(_wbtc);
        uni = IERC20(_uni);

        super.setUp();
        super.deployHarness();
    }

    // Fund users with deposit tokens if needed
    function fundUsers(address[] memory users) internal {
        _depositTokenWhale = 0x40ec5B33f54e0E8A33A975908C5BA1c14e5BbbDf;

        (bool success, bytes memory data) = _depositToken.call(
            abi.encodeWithSignature("decimals()")
        );

        if (success) {
            depositTokenDecimals = abi.decode(data, (uint256));
        } else {
            console.log("Failed Decimals Call, Assuming 18 Decimals");
            depositTokenDecimals = 18;
        }

        standardAmount = 10 ** depositTokenDecimals;

        for (uint256 i; i < users.length; ++i) {
            vm.prank(_depositTokenWhale);
            depositToken.transfer(users[i], 1000 * standardAmount);
        }
    }
}
