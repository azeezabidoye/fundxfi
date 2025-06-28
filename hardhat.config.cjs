require("@nomicfoundation/hardhat-toolbox");
require("dotenv").config();
require("hardhat-gas-reporter");
require("solidity-coverage");

const { PRIVATE_KEY, CROSSFI_ALCHEMY_URL, CONINMARKET_API_KEY } = process.env;

/** @type import('hardhat/config').HardhatUserConfig */

module.exports = {
  solidity: "0.8.28",
  networks: {
    hardhat: { chainId: 1337 },
    crossfiTestnet: {
      url: CROSSFI_ALCHEMY_URL,
      accounts: [PRIVATE_KEY],
      chainId: 4157,
    },
  },
  gasReporter: {
    enabled: true,
    currency: "XFI",
    coinmarketcap: COINMARKETCAP_API_KEY,
    showTimeSpent: true,
    excludeContracts: [],
    noColors: false,
  },
};
