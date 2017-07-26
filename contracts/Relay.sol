pragma solidity ^0.4.11;

contract Relay {
  address public currentVersion;
  address public owner;

  modifier onlyOwner() {
    if (msg.sender != owner) {
      throw;
    }
    _;
  }

  function Relay(address initAddr) {
    currentVersion = initAddr;
    owner = msg.sender; // this owner may be another contract with multisig, not a single contract owner
  }

  function changeContract(address newVersion) public onlyOwner {
    currentVersion = newVersion;
  }
	
	function delegateCall() {
		if(!currentVersion.delegatecall(bytes4(sha3("addNum(uint256)")), 10)) throw;
	}

  function() {
    //if(!currentVersion.call.value(0)(msg.data)) throw;
    if(!currentVersion.delegatecall(msg.data)) throw;
    //if(!currentVersion.delegatecall( bytes4(sha3("addNum(uint256)")), 10) ) throw;
  }
}