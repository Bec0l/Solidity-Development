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
    function vote(uint256 _proposalId) public {
       
        require(proposalForVoting.length > 0, "No proposals available to vote for.");
        require(_proposalId < proposalForVoting.length, "Invalid proposal.");
        
        uint id;

        for (uint i=0; i<member.length; i++){
            if (member[i].addr == msg.sender){
                id = i;
            } 
        }  

        require(member[id].isMember, "You are not a member.");
        require(!member[id].voted, "You have already voted.");
       
        proposalForVoting[_proposalId].votesPerProposal++;
      
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