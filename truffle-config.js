const fs = require('fs');
const HDWalletProvider = require('truffle-hdwallet-provider');

const mnemonic = fs.readFileSync('.secret').toString().trim();
const infuraEndpoint = 'https://rinkeby.infura.io/v3/b56f6b78f6934dedbd8fc431137ee12b';

module.exports = {
  compilers: {
    solc: {
      version: '0.5.0',
      settings: {
        optimizer: {
          enabled: true,
          runs: 200
        }
      }
    }
  },
  networks: {
    development: {
      host: '127.0.0.1',
      port: 8545,
      network_id: '*'
    },
    rinkeby: {
      provider() {
        return new HDWalletProvider(mnemonic, infuraEndpoint);
      },
      network_id: 4
    }
  }
};
