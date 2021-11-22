async function main() {
  const EzMintFactory = await ethers.getContractFactory("EzMintFactory")

  // Start deployment, returning a promise that resolves to a contract object
  const ezMintFactory = await EzMintFactory.deploy()
  console.log("Contract deployed to address:", ezMintFactory.address)
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error)
    process.exit(1)
  })
