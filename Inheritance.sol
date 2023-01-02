//SPDX-License-Identifier: MIT

pragma solidity ^0.8.8;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract LoveToken is ERC20 {
    constructor(uint256 initialSupply) ERC20("Love", "LOV") {
        _mint(msg.sender, 42069);
    }
}