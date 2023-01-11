pragma solidity 0.8.4;  //Do not change the solidity version as it negativly impacts submission grading
// SPDX-License-Identifier: MIT

import "@openzeppelin/contracts/access/Ownable.sol";
import "./YourToken.sol";

contract Vendor is Ownable {

  event BuyTokens(address buyer, uint256 amountOfETH, uint256 amountOfTokens);
  event SellTokens(address, uint256, uint256);

  YourToken public yourToken;

  constructor(address tokenAddress) {
    yourToken = YourToken(tokenAddress);
  }

  uint256 public constant tokensPerEth = 100;

  // ToDo: create a payable buyTokens() function:

  function buyTokens() public payable {
   uint256 amountOfETH = msg.value;
   uint256 amountOfTokens = msg.value * tokensPerEth;
   address buyer = payable(msg.sender);
    
    yourToken.transfer(buyer, amountOfTokens);

    emit BuyTokens(buyer, amountOfETH, amountOfTokens);
  }

  // ToDo: create a withdraw() function that lets the owner withdraw ETH
  function withdraw () public onlyOwner{
    uint256 amount = address(this).balance;
    (bool success, ) = payable(msg.sender).call{value: amount}("");
        require(success, "Withdraw failed.");
  }

  // ToDo: create a sellTokens(uint256 _amount) function:
  function sellTokens(uint256 theAmount) public payable{
    uint256 amount = theAmount/tokensPerEth;
    yourToken.transferFrom(msg.sender, address(this), theAmount);
    (bool success, ) = payable(msg.sender).call{value: amount}("");
        require(success, "Not enough ETH to buy.");
    
    emit SellTokens(msg.sender, amount, theAmount);
  }
}
