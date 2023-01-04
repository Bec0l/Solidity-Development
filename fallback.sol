//SPDX-License-Identifier: MIT

pragma solidity ^0.8.8;

contract FallbackContract {

    mapping (address=>uint256) private balance;
    
    function deposit() payable public {
        balance[msg.sender] += msg.value;
    }

    function checkBalance() public view returns(uint256) {
        return balance[msg.sender];
    }

    // falback task:

    event Log(address sender);

    function fallBack() external payable {
        emit Log(msg.sender);
    }
}