//SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;

contract MappingsStructs {

    struct UserDetails {
        string userName;
        uint256 userAge;
    }

    UserDetails[] public userDetails;

    mapping (address=>uint256) private balance;
    
    function deposit(uint256 amount) public {
        balance[msg.sender] += amount;
    }

    function checkBalance() public view returns(uint256) {
        return balance[msg.sender];
    }
   
    function setUserDetails( string calldata name, uint256 age) public {
        userDetails.push(UserDetails({userName: name, userAge: age}));
    }

    function getUserDetail() public view returns (string memory userName, uint256 userAge) {
        UserDetails storage userDetails = userDetails[0];
        return (userDetails.userName, userDetails.userAge);
    }

}

