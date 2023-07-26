const HDWalletProvider = require("@truffle/hdwallet-provider");
const privateKeys = [
  "d2c587d81f443ab3bac6adf24cd742b1829b7100c6fa34881a75e41d5e66f368",
];
module.exports = {
  /**
   * Networks define how you connect to your ethereum client and let you set the
   * defaults web3 uses to send transactions. If you don't specify one truffle
   * will spin up a managed Ganache instance for you on port 9545 when you
   * run `develop` or `test`. You can ask a truffle command to use a specific
   * network from the command line, e.g
   *
   * $ truffle test --network <network-name>
   */

  networks: {
    development: {
      host: "127.0.0.1", // Localhost (default: none)
      port: 7545, // Standard BSC port (default: none)
      network_id: "*", // Any network (default: none)
    },
    testnet: {
      provider: () =>
        new HDWalletProvider(
          privateKeys,
          `https://endpoints.omniatech.io/v1/bsc/testnet/public`
        ),
      network_id: 97,
      confirmations: 2,
      timeoutBlocks: 1000,
      skipDryRun: true,
    },
  },

  // Set default mocha options here, use special reporters, etc.
  mocha: {
    // timeout: 100000
  },

  // Configure your compilers
  compilers: {
    solc: {
      version: "0.8.4",
    },
  },
};
