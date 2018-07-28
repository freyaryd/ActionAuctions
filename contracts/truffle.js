require("babel-register");
require("babel-polyfill");

const HDWalletProvider = require("truffle-hdwallet-provider");

// TODO -- insert mnemonic here
const mnemonic = "";

module.exports = {
  build: require("./build"),
  networks: {
    development: {
      host: "127.0.0.1",
      port: 8545,
      network_id: "*"
    },
    ropsten: {
      provider: function() {
        return new HDWalletProvider(mnemonic, "https://ropsten.infura.io/");
      },
      network_id: 3
    }
  }
};
