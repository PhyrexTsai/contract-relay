pragma solidity ^0.4.11;

contract Counter {
  uint256 public counter;
  address public owner;
  address public who;

  event Log(address _owner, address _sender);

  modifier onlyOwner() {
    if (owner != msg.sender) throw;
    _;
  }

  function Counter() {
    owner = msg.sender;
  }

  function addNum(uint256 num) {
    counter = counter + num;
  }

  function setWho() {
    who = msg.sender;
  }
}