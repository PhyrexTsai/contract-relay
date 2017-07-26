var Relay = artifacts.require("./Relay.sol");
var Counter = artifacts.require("./Counter.sol");

module.exports = function(deployer) {
  deployer.deploy(Counter);
  deployer.deploy(Relay, "0x0");
};
