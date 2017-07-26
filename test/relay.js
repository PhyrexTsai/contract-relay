var Counter = artifacts.require("./Counter.sol");
var Relay = artifacts.require("./Relay.sol");
var abi = require("ethereumjs-abi");

contract("Relay", function(accounts) {
  var relay;
  var counter;
  it("relay", function() {
    return Counter.deployed().then(function(counterInstance) {
      counter = counterInstance;
      return Relay.deployed().then(function(relayInstance) {
        relay = relayInstance;
        console.log("Counter.address: ", counter.address);
        console.log("Relay.address: ", relay.address);
        return relay.changeContract(counter.address);
      }).then(function() {
        return relay.currentVersion.call();
      }).then(function(currentVersion) {
        assert.equal(currentVersion, counter.address, "counter address wasn't correctly");
        var encoded = "0x" + abi.methodID("addNum", [ "uint256" ]).toString("hex") + abi.rawEncode([ "uint256" ], [ 10 ]).toString("hex");
        console.log(encoded);
        web3.eth.sendTransaction({ from: accounts[0], to: relay.address, data: encoded });
        //web3.eth.sendTransaction({ from: accounts[0], to: counter.address, data: "0x" + encoded });
        return counter.counter.call();
      }).then(function(counter) {
        console.log("counter", counter.toNumber());
        assert.equal(counter.toNumber(), 10, "counter wasn't corretly");
      });
    });
  });
});
