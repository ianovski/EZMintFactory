# EZMintFactory
Factory for creating and tracking EZMint contracts 

## Add environment variables
Create a .env file in the project's root directory. It should look like this:
```
API_URL="https://eth-rinkeby.alchemyapi.io/v2/your-api-key"
PRIVATE_KEY="your-private-key"
PUBLIC_KEY="your-public-key"
CONTRACT_ADDRESS="your-deployed-contract-address"
ETH_SCAN_API_KEY="etherscan-api-key"
```

## Install imported contracts
`npm install @openzeppelin/contracts`

## Install dependencies
`npm install --save-dev hardhat`

`npm install dotenv --save`

`npm install --save-dev @nomiclabs/hardhat-ethers 'ethers@^5.0.0'`

`npm install --save-dev @nomiclabs/hardhat-etherscan 'ethers@^5.0.0'`

`npm install @alch/alchemy-web3`

## Compile
`npx hardhat compile`

## Deploy Contract
`npx hardhat run scripts/deploy.js --network rinkeby`

Update contract address in .env file

## Add new project
Update the `addProject` function with the corresponding project variables at the bottom of the `add-project.js` script

`node scripts/add-project.js`

### Verify contract
`npx hardhat verify --network rinkeby <Contract Address>`