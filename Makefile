-include .env

.PHONY: forge script test anvil snapshot

interface:
	forge build && forge inspect TestContract abi > abi.json && cast interface abi.json -o src/interfaces/ITestContract.sol -n ITestContract && forge inspect Harness abi > abi.json && cast interface abi.json -o test/harness/IHarness.sol -n IHarness && script/Bash/modifyInterface.sh


