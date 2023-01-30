// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";

contract Voting is Ownable {

    struct Proposals {
        string proposal;
        uint256 votesPerProposal;
    }

    Proposals[] public proposalForVoting;

    struct Member {
        address addr;
        bool voted;
        bool isMember;
    }

    
    
    Member[] public member;

    event Results (string, uint256 );

    // modifier memberOnly() {
    //     require(member[i].isMember = true, "You are not a member");
    //     _;
    // }

    function addMember(address _address) public onlyOwner {
        member.push(Member(_address, false, true));
        
    }

   function addProposal(string memory _proposal) public onlyOwner {
        proposalForVoting.push(Proposals(_proposal,0));
    } 

// function to add votes to the variable votesPerProposal. _porposalID is the position in the array
    function vote(uint256 _proposalId) public returns (string memory) {
        //require (!member(voted), "You have voted already.");
        require(proposalForVoting.length > 0, "No proposals available to vote for.");
        require(_proposalId < proposalForVoting.length, "Invalid proposal.");
        
        proposalForVoting[_proposalId].votesPerProposal++;
        
        for (uint i=0; i<member.length; i++){
            if (member[i].addr == msg.sender){
                member[i].voted = true;
            } else {
                return "You are not a member.";
            }
        }  
    } 
            
            
         
  
    function showResults() public  {
        for (uint i = 0; i < proposalForVoting.length; i++) {
            emit Results (proposalForVoting[i].proposal, proposalForVoting[i].votesPerProposal);
        }
    }

    function reset() public onlyOwner {
        for (uint i = 0; i < member.length; i++) {
            member[i].voted = false;
        }

        while(proposalForVoting.length>0){
            proposalForVoting.pop();
        }

    }

}