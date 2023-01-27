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
        address add;
        bool voted;
        
    }

    bool isMember;
    
    constructor () { 
        for (uint i=0; i<member.length; i++){
            if (member[i].add == msg.sender){
                isMember = true;
            } isMember = false;
        }
    }
   
    Member[] public member;

    event Results (string, uint256 );

    modifier memberOnly() {
        require(isMember = true, "You are not a member");
        _;
    }

    function addMember(address _address) public onlyOwner {
        member.push(Member(_address, false));
        
    }

   function addProposal(string memory _proposal) public onlyOwner {
        proposalForVoting.push(Proposals(_proposal,0));
    } 

// functio to add votes to the variable votesPerProposal. _porposalID is the position in the array
    function vote(uint256 _proposalId) public memberOnly{
        //require (!member(voted), "You have voted already.");
        require(proposalForVoting.length > 0, "No proposals available to vote for.");
        require(_proposalId < proposalForVoting.length, "Invalid proposal.");
        proposalForVoting[_proposalId].votesPerProposal++;
        
        for (uint i=0; i<member.length; i++){
            if (member[i].add == msg.sender){
                member[i].voted = true;
            }
        }
        
    }

    function showResults() public memberOnly {
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