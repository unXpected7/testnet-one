. Compile the Contract
Run:
npx hardhat compile
7. Deploy to Sepolia
Run:
npx hardhat run scripts/deploy.ts --network sepolia
8. Verify the Contract on Etherscan

npx hardhat verify --network sepolia <contract_address> 1000000
