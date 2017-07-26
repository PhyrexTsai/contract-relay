pragma solidity ^0.4.2;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/Counter.sol";
import "../contracts/Relay.sol";

contract TestRelay {

  function testRelay() {
    Counter counter = new Counter();
    Relay relay = new Relay(DeployedAddresses.Counter());
    
    Assert.equal(relay.currentVersion(), DeployedAddresses.Counter(), "Counter address should set correctly");
  }

  function testCallUsingRelay() {
    Counter counter = new Counter();
    Relay relay = new Relay(DeployedAddresses.Counter());
  
    bytes4 methodId = bytes4(sha3("addNum(uint256)"));
    counter.call(methodId, 10);

    Assert.equal(counter.counter(), 10, "Counter counter should set correctly");
  }

  function testDelegateCallUsingRelay() {
    Counter counter = new Counter();
    Relay relay = new Relay(DeployedAddresses.Counter());

    relay.delegateCall();

    Assert.equal(counter.counter(), 10, "Counter counter should set correctly");
  }

}
