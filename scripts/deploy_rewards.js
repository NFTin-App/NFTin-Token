const hre = require("hardhat");

async function main() {

  const CallRewards = await hre.ethers.getContractFactory("CallRewards");
  const callRewards = await CallRewards.deploy();

  await callRewards.deployed();

  console.log(
    `deployed to ${callRewards.address}`
  );
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
