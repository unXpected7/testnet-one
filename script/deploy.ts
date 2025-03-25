import { ethers as hardhatEthers } from "hardhat";

const deployContract = async () => {
  const [deployer] = await hardhatEthers.getSigners();
  console.log(`Deploying contract with account: ${deployer.address}`);

  const initialSupply = hardhatEthers.parseUnits("1000000", 18); // 1M tokens
  const feeRecipient = "0xYourFeeRecipientAddress"; // Replace with actual wallet address

  const TokenFactory = await hardhatEthers.getContractFactory("one");
  const token = await TokenFactory.deploy(initialSupply, feeRecipient);

  await token.waitForDeployment();
  console.log(`Token deployed at: ${await token.getAddress()}`);
};

deployContract().catch((error) => {
  console.error(error);
  process.exit(1);
});
