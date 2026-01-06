# Memory vs Calldata Gas Optimization Demo

This project demonstrates the gas efficiency difference between using `memory` and `calldata` for array parameters in Solidity functions.

## Overview

When writing external functions that accept array parameters, using `calldata` instead of `memory` can significantly reduce gas costs. This is because:

- **`memory`** copies the entire array from calldata into memory, which costs gas
- **`calldata`** reads directly from the transaction input data without copying

## The Comparison

The `Airdrop.sol` contract contains two identical functions that perform token airdrops:

```solidity
// ❌ Less efficient - uses memory (copies data)
function badAirdrop(address[] memory recipients, uint256[] memory amounts) external {
    for (uint256 i = 0; i < recipients.length; i++) {
        token.transfer(recipients[i], amounts[i]);
    }
}

// ✅ More efficient - uses calldata (reads directly)
function goodAirdrop(address[] calldata recipients, uint256[] calldata amounts) external {
    for (uint256 i = 0; i < recipients.length; i++) {
        token.transfer(recipients[i], amounts[i]);
    }
}
```

## Gas Report Results

Running `forge test --gas-report -vv` with **1,000 recipients**:

| Function | Gas Used | Difference |
|----------|----------|------------|
| `badAirdrop` (memory) | 27,838,295 | Baseline |
| `goodAirdrop` (calldata) | 27,617,798 | **-220,497 gas** ⚡ |

### Key Takeaways

- **220,497 gas saved** (~0.8% reduction) for 1,000 recipients
- **~220 gas saved per recipient**
- At typical gas prices, this could save $50-100+ per airdrop!
- The savings scale linearly with the number of recipients

## Running the Tests

```shell
# Install dependencies
forge install

# Run tests
forge test

# Run tests with gas report
forge test --gas-report

# Run tests with detailed gas snapshot
forge snapshot
```

## Best Practice

✅ **Always use `calldata` for array/string parameters in `external` functions when you don't need to modify the data**

This is one of the most common and impactful gas optimizations in Solidity!

---

