#!/bin/bash

# Fixed filepath for the interface
INTERFACE_FILE="test/harness/IHarness.sol"

# Check if interface file exists
if [ ! -f "$INTERFACE_FILE" ]; then
    echo "Error: Interface file not found at $INTERFACE_FILE"
    exit 1
fi

# Modify the interface file in place using sed
sed -i '
    # Add import after pragma line
    /pragma solidity/ a import {HarnessState} from "test/harness/Harness.sol";
    # Remove struct definition
    /struct HarnessState {/,/}/ d
' "$INTERFACE_FILE"

echo "Successfully modified test/harness/IHarness.sol"
