
const hre = require("hardhat");

async function main() {

  const TinToken = await hre.ethers.getContractFactory("TinToken");
  const tinToken = await TinToken.deploy();

  await tinToken.deployed();

  console.log(
    `deployed to ${tinToken.address}`
  );
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
