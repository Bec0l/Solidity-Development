// SPDX-License-Identifier: MIT
pragma solidity 0.8.4;  //Do not change the solidity version as it negativly impacts submission grading

import "hardhat/console.sol";
import "./ExampleExternalContract.sol";

contract Staker {

  ExampleExternalContract public exampleExternalContract;

  constructor(address exampleExternalContractAddress) {
      exampleExternalContract = ExampleExternalContract(exampleExternalContractAddress);
  }

  //And also track a constant threshold at 1 ether
  uint256 public constant threshold = 1 ether;

  uint256 public deadline = block.timestamp + 30 seconds;
  
  bool openForWithdraw;

  bool isExecuted;


  // ( Make sure to add a `Stake(address,uint256)` event and emit it for the frontend <List/> display )
  event Stake(address, uint256);


  // Collect funds in a payable `stake()` function and track individual `balances` with a mapping:
  mapping (address => uint256) public balances;

  function stake () public payable{
    require(block.timestamp < deadline, "deadline reached");
    require(msg.value > 0, "Insufficient value");
    balances[msg.sender] += msg.value;
    emit Stake(msg.sender, msg.value);
  }

  

  // After some `deadline` allow anyone to call an `execute()` function
  // If the deadline has passed and the threshold is met, it should call `exampleExternalContract.complete{value: address(this).balance}()`
  function execute() public {
    require(isExecuted = true, "Already executed");
    require(block.timestamp > deadline, "deadline not reached");
    if (balances[msg.sender] >= threshold) {
      exampleExternalContract.complete{value: address(this).balance}();
    } else {
      openForWithdraw = true;
    }
    isExecuted = true;
    
  }


  // If the `threshold` was not met, allow everyone to call a `withdraw()` function to withdraw their balance
  function withdraw() external {
   uint256 amount = balances[msg.sender];
    require(openForWithdraw = true, "Contract not executed");
    require(balances[msg.sender] > 0, "Insuficient funds");
    (bool success, ) = payable(msg.sender).call{value: amount}("");
        require(success, "Withdraw failed."); 
  }

  // Add a `timeLeft()` view function that returns the time left before the deadline for the frontend
  function timeLeft() public view returns(uint _timeLeft) {
    if(block.timestamp >= deadline) {
      _timeLeft = 0;
    } else {
      _timeLeft = deadline - block.timestamp;
    }
  }

  // Add the `receive()` special function that receives eth and calls stake()
  receive() external payable {
    stake();
  }
}
