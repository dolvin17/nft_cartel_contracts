import type { HardhatUserConfig } from "hardhat/config"
import "@nomicfoundation/hardhat-toolbox"
import "dotenv/config"

const argv = require("yargs/yargs")(process.argv.slice(2)).parse()
const NETWORK = argv.network as string

const ETHERSCAN_BASE_KEY = process.env.ETHERSCAN_BASE_KEY!
const DEPLOYER_PK = process.env.DEPLOYER_PK!

const ETHERSCAN_API_KEY =
  {
    baseMainnet: ETHERSCAN_BASE_KEY,
  }[NETWORK] || ETHERSCAN_BASE_KEY // default to ethereum

console.debug("Network:", NETWORK || "N/A")


const config: HardhatUserConfig = {
  sourcify: {
    enabled: true,
  },
  solidity: {
    version: "0.8.24",
    settings: {
      optimizer: {
        enabled: true,
        runs: 200,
      },
    },
  },
  etherscan: {
    enabled: true,
    apiKey: ETHERSCAN_API_KEY,
    customChains: [
      {
        chainId: 43114,
        // base mainnet
        network: "baseMainnet",
        urls: {
          apiURL: "https://api.basescan.io/api",
          browserURL: "https://basescan.io",
        },
      },
	  {
        chainId: 2710,
        // sepolia eth mainnet
        network: "ethSepolia",
        urls: {
          apiURL: "https://api-sepolia.etherscan.io/api",
          browserURL: "https://sepolia.etherscan.io",
        },
      },
    ],
  },
  networks: {
    baseMainnet: {
      url: "https://mainnet.base.org",
      accounts: [DEPLOYER_PK],
    },
	ethSepolia: {
		url: "https://ethereum-sepolia-rpc.publicnode.com/",
	  accounts: [DEPLOYER_PK],
	},
  },
}

export default config