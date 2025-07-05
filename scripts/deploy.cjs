const { ethers } = require("hardhat");

async function main() {
  // Get the contract factory
  const FundXFI = await ethers.getContractFactory("FundXFI");

  console.log("Deploying FundXFI contract...");
  const fundxfi = await FundXFI.deploy(); // No constructor args needed
  await fundxfi.waitForDeployment();
  const fundxfiAddr = await fundxfi.getAddress();

  console.log(`✅ Contract deployed at: ${fundxfiAddr}`);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error("❌ Deployment failed:", error);
    process.exit(1);
  });
