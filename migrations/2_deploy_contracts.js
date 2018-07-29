var Auction = artifacts.require("ActionAuctions");

module.exports = function(deployer) {
  deployer.deploy(Auction);
};
