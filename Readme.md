# YulOwnerShipTesting

## Test
```
forge test
```

## Log
```
Ran 8 tests for test/Bank.t.sol:BankTest
[PASS] testFail_TransferOwnershipNotOwner() (gas: 14711)
[PASS] testFail_TransferOwnershipToZeroAddress() (gas: 12915)
[PASS] testFuzz_TransferOwnership(address) (runs: 1000, μ: 19063, ~: 19063)
[PASS] test_InitialState() (gas: 12792)
[PASS] test_OnlyOwnerModifier() (gas: 15680)
[PASS] test_ReceiveEther() (gas: 18670)
[PASS] test_TransferOwnership() (gas: 20999)
[PASS] test_TransferOwnershipEvent() (gas: 21679)
Suite result: ok. 8 passed; 0 failed; 0 skipped; finished in 32.51ms (33.37ms CPU time)

Ran 1 test suite in 35.05ms (32.51ms CPU time): 8 tests passed, 0 failed, 0 skipped (8 total tests)
```
