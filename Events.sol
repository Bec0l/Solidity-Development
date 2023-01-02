//SPDX-License-Identifier: MIT

pragma solidity ^0.8.7;

contract MappingsStructs {

    //creating variables
    address public owner;
    uint256 public fee;

    //modifier owner only
    modifier ownerOnly() {
        require(msg.sender == owner);
        _;
    }

    //add event for deposited funds
    event FundsDeposited (address user, uint256 amount);

    //add event for updated profile
    event ProfileUpdated(address user);

    struct UserDetails {
        string userName;
        uint256 userAge;
    }

    UserDetails[] public userDetails;

    mapping (address=>uint256) private balance;
    
    function deposit(uint256 amount) public {
        balance[msg.sender] += amount;
        emit FundsDeposited(user, amount); //emit event
    }

    function checkBalance() public view returns(uint256) {
        return balance[msg.sender];
    }

    //modifier amount too small
    modifier value (uint256 _amount) {
        require (_amount >= fee, "Amount too small.");
        _;
    }


    //modifier for only depositor
    modifier depositorOnly (){
        require(balance[msg.sender] >= 0, "No balance yet.");
        _;
    }
    
    // add fund function
    function addFund (uint256 _amount) public depositorOnly value(_amount) {
        balance[msg.sender] += _amount;
    }

    //add a withdraw function
    function withdraw(uint256 amount) public ownerOnly{
        uint256 amount = address(this).balance;  
    }
   
    function setUserDetails( string calldata name, uint256 age) public {
        userDetails.push(UserDetails({userName: name, userAge: age}));
        emit ProfileUpdated(user); //emit event
    }

    function getUserDetail() public view returns (string memory userName, uint256 userAge) {
        UserDetails storage userDetails = userDetails[0];
        return (userDetails.userName, userDetails.userAge);
    }

}

