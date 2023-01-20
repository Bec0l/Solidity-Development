// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Voting {
    address public owner;
    mapping (address => bool) public members;
    mapping (uint256 => uint8) public votesReceived;
    mapping (address => bool) public voted;
    string[] public proposals;
    bool public resultsShown;
    
    event Results(uint8[] votes);
    


    constructor() public {
        owner = msg.sender;
    }

    function addMember(address member) public {
        require(msg.sender == owner, "You are not the owner.");
        members[member] = true;
    }

    function addProposal(string memory proposal) public {
        require(msg.sender == owner, "You are not the owner.");
        proposals.push(proposal);
    }

    function vote(uint256 proposal) public {
        require(!resultsShown, "Voting closed.");
        require(members[msg.sender], "You are not a member.");
        require(proposals.length > 0, "No proposals available to vote for.");
        require(proposal < proposals.length, "Invalid proposal.");
        require(!voted[msg.sender], "You have already voted.");
        votesReceived[proposal]++;
        voted[msg.sender] = true;
    }

    function changeOwner(address newOwner) public {
        require(msg.sender == owner, "You are not the owner.");
        owner = newOwner;
    }
    
    function showResults() public returns (uint8[] memory) {
        require(!resultsShown, "Results already shown.");
        
        uint8[] memory result = new uint8[](proposals.length);
        for (uint i = 0; i < proposals.length; i++) {
            result[i] = votesReceived[i];
        }
        resultsShown = true;
        
        emit Results(result);
    }

    // to support receiving ETH by default
  receive() external payable {}
  fallback() external payable {}

}