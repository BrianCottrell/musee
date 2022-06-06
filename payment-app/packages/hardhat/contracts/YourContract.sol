pragma solidity >=0.8.0 <0.9.0;

import "hardhat/console.sol";

contract YourContract {
  address owner;
  address[] participants;
  uint[] percentages;
  uint thresholdValue;
  uint[] thresholdPercentages;
  mapping(address => uint) balances;

  constructor() payable {
  }

  function deposit() public payable {
    balances[msg.sender] += msg.value;
  }

  function addParticipant(address payable participant, uint percentage, uint thresholdPercentage) public {
    participants.push(participant);
    percentages.push(percentage);
    thresholdPercentages.push(thresholdPercentage);
  }

  function setThreshold(uint threshold) public {
    thresholdValue = threshold;
  }

  function payParticipants() public {
    uint share;
    bool thresholdReached = (address(this).balance > thresholdValue);
    uint[] memory sharePercentages = thresholdReached ? thresholdPercentages : percentages;
    for (uint i = 0; i < participants.length; i++) {
      share = uint(address(this).balance * sharePercentages[i]) / uint(100);
      payable(participants[i]).transfer(share);
      balances[msg.sender] -= share;
    }
  }

  // to support receiving ETH by default
  receive() external payable {}
  fallback() external payable {}
}
