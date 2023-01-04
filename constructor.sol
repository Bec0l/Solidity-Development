// SPDX-License-Identifier: MIT

pragma solidity ^0.8.8;

// Base contract A
contract A {
    address immutable owner;
    uint256 public FEE;

    constructor (uint _fee) {
        owner = msg.sender;
        FEE = _fee;
    }
}


// Contract B inheriting A
contract B is A {

    address immutable _owner;
  
    constructor () A(20) {
       _owner = msg.sender;
    }
}