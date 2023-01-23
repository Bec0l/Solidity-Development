// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/ownership/Ownable.sol";

contract Voting is Ownable {
    mapping (address => bool) public members;
    mapping (uint256 => uint8) public votesReceived;
    string[] public proposals;
    bool public resultsShown;

    struct Voted {
        bool voted;
    }
    
    event Results(uint8[] votes);
    
    function addMember(address member) public onlyOwner {
        members[member] = true;
    }

    function addProposal(string memory proposal) public onlyOwner {
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
        voters.push(msg.sender);
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

    function reset() public onlyOwner {
        require(!voters[msg.sender].voted, "You have already voted.");
        resultsShown = false;
        voted = false;
        while(proposals.length>0){
            proposals.pop();
        }
        

    } 
}