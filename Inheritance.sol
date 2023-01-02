// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract Coffee is ERC20 {
    constructor() ERC20("Coffee", "COF") {
       _mint(msg.sender, 420690000000000000); 
    }
}

// https://goerli.etherscan.io/token/0xebb50880377d5ce1e316edc768463b4703f687d0?a=0x3DEe9017684E42056F03a19636D1Fd217Ce5b2A5 