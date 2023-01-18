pragma solidity ^0.8.0;

contract Voting {
    address public owner;
    mapping (address => bool) public members;
    mapping (bytes32 => uint8) public votesReceived;
    bytes32[] public proposals;

    constructor() public {
        owner = msg.sender;
    }

    function addMember(address member) public {
        require(msg.sender == owner, "You are not the owner.");
        members[member] = true;
    }

    function addProposal(bytes32 proposal) public {
        require(msg.sender == owner, "You are not the owner.");
        proposals.push(proposal);
    }

    function vote(bytes32 proposal) public {
        require(members[msg.sender], "You are not a member.");
        require(proposals.length > 0, "No proposals available to vote for.");
        require(proposals[proposal] !== undefined, "Invalid proposal.");
        votesReceived[proposal]++;
    }

    function totalVotesFor(bytes32 proposal) public view returns (uint8) {
        require(proposals.length > 0, "No proposals available to vote for.");
        require(proposals[proposal] !== undefined, "Invalid proposal.");
        return votesReceived[proposal];
    }

    function changeOwner(address newOwner) public {
        require(msg.sender == owner, "You are not the owner.");
        owner = newOwner;
    }
}
