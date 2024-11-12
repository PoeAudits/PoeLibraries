// SPDX-License-Identifier: AGPL-3.0-only
pragma solidity ^0.8.0;

import {console2 as console} from "lib/forge-std/src/Test.sol";

abstract contract Gas {
    event LogGas(string message, uint256 val);

    string private checkpointLabel;
    uint256 private checkpointGasLeft = 1; // Start the slot warm.

    ///@dev Seems to work better if you burn the first gas call for some reason
    ///@dev Otherwise first call of function will add ~4k gas compared to second call
    function __Gas_init() internal {
        startMeasuringGas("Burn");
        stopMeasuringGas();
    }

    ///@dev Gas checking from Solmate: https://github.com/Vectorized/solmate/blob/main/src/test/utils/DSTestPlus.sol
    ///@dev If anyone knows how best to test gas its them
    function startMeasuringGas(string memory label) internal virtual {
        checkpointLabel = label;

        checkpointGasLeft = gasleft();
    }

    function stopMeasuringGas() internal virtual {
        uint256 checkpointGasLeft2 = gasleft();

        // Subtract 100 to account for the warm SLOAD in startMeasuringGas.
        uint256 gasDelta = checkpointGasLeft - checkpointGasLeft2 - 100;

        emit LogGas(
            string(abi.encodePacked(checkpointLabel, " Gas")),
            gasDelta
        );
        console.log(
            string(abi.encodePacked(checkpointLabel, " Gas")),
            gasDelta
        );
    }
}
