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
    balances[msg.sender] += msg.value;
    emit Stake(msg.sender, msg.value);
  }

  

  // After some `deadline` allow anyone to call an `execute()` function
  // If the deadline has passed and the threshold is met, it should call `exampleExternalContract.complete{value: address(this).balance}()`
  function execute() public {
    require(isExecuted = false, "Already executed");
    require(block.timestamp > deadline, "deadline not reached");
    if (address(this).balance >= threshold) {
      exampleExternalContract.complete{value: address(this).balance}();
    } else {
      openForWithdraw = true;
    }
    isExecuted = true;
  }


  // If the `threshold` was not met, allow everyone to call a `withdraw()` function to withdraw their balance
  function withdraw(uint256 amount) public {
    require(openForWithdraw = true, "Contract not executed");
    require(address(this).balance > 0, "Insuficient funds");
     uint256 amount = address(this).balance; 
  }

  // Add a `timeLeft()` view function that returns the time left before the deadline for the frontend
  function timeLeft() public view returns (uint256) {
    
  }

  // Add the `receive()` special function that receives eth and calls stake()

}
