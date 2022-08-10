const hre = require("hardhat");

async function main() {
    const Acution = await hre.ethers.getContractFactory("auction");
    const auction = await auction.deploy(360,msg.sender);
    await auction.deployed();
    console.log("contract deployed to that address:", auction.address);

let dep = await auction.functions.bid();
console.log(dep);

let dev = await auction.functions.withdraw();
console.log(dev);

let det = await auction.functions.endtime();
console.log(det);


}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
