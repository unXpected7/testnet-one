# Interacting with One Token Smart Contract

## Prerequisites
Before interacting with the smart contract, ensure you have:
- Installed [Hardhat](https://hardhat.org/)
- Deployed your smart contract to Sepolia (or another Ethereum network)
- The contract address from the deployment output

## Connect to the Hardhat Console
Run the following command to open the interactive Hardhat console:
```sh
npx hardhat console --network sepolia
```

## Load the Smart Contract
Replace `0xYourContractAddress` with the actual deployed contract address:
```js
const token = await ethers.getContractAt("AdvancedToken", "0xYourContractAddress");
```

## Check Token Balance
Replace `0xYourWalletAddress` with the actual wallet address:
```js
(await token.balanceOf("0xYourWalletAddress")).toString();
```

## Pause/Unpause Transfers (Only Owner)
```js
await token.togglePause();
```

## Mint New Tokens (Only Owner)
Replace `0xRecipientAddress` with the wallet address that will receive new tokens:
```js
await token.mint("0xRecipientAddress", ethers.parseUnits("1000", 18));
```

## Burn Tokens (Only Owner)
```js
await token.burn(ethers.parseUnits("500", 18));
```

## Blacklist an Address (Only Owner)
```js
await token.setBlacklist("0xBlacklistedAddress", true);
```

## Remove an Address from Blacklist (Only Owner)
```js
await token.setBlacklist("0xBlacklistedAddress", false);
```

## Check if an Address is Blacklisted
```js
await token.isBlacklisted("0xSomeAddress");
```

## Set a New Transaction Fee (Only Owner)
Set the transaction fee in basis points (10 = 1%):
```js
await token.setTransactionFee(10);
```

## Change the Fee Recipient (Only Owner)
Replace `0xNewFeeRecipient` with the new recipient address:
```js
await token.setFeeRecipient("0xNewFeeRecipient");
```

## Transfer Tokens
Send tokens to another address (replace with actual addresses and amounts):
```js
await token.transfer("0xRecipientAddress", ethers.parseUnits("100", 18));
```

---

### Notes
- **Only the contract owner** can execute functions marked as "Only Owner".
- **Ensure you have test ETH** in your wallet for gas fees when interacting with the contract.
- **Verify transactions** on [Etherscan](https://sepolia.etherscan.io/) by searching for your wallet or contract address.

🎉 Happy Building! 🚀

