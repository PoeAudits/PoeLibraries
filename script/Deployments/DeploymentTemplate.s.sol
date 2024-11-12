// SPDX-License-Identifier: UNLICENSED

pragma solidity 0.8.20;

import "../BaseDeploy.sol";

contract DeploymentTemplate is BaseDeploy {
    ///@dev 10th Anvil generated addresses
    address internal _admin = 0xa0Ee7A142d267C1f36714E4a8F75612F20a79720;

    IERC20 internal depositToken;

    address internal _depositToken;
    uint256 internal depositTokenDecimals;

    ///@dev Transfering from existing wallets seems to work most reliably
    address internal _depositTokenWhale;

    ///@dev Using standard amount to avoid tests breaking on decimal changes
    uint256 standardAmount;

    function setUp() public virtual override {
        _depositToken = 0x0000000000000000000000000000000000000000;
        depositToken = IERC20(_depositToken);
        super.setUp();
        super.deployHarness();
    }

    // Fund users with deposit tokens if needed
    function fundUsers(address[] memory users) internal {
        _depositTokenWhale = 0x0000000000000000000000000000000000000000;

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
