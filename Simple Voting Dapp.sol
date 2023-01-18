pragma solidity ^0.8.0;

contract Voting {
    address public owner;
    mapping (address => bool) public voters;
    mapping (bytes32 => uint8) public votesReceived;
    bytes32[] public candidates;

    constructor() public {
        owner = msg.sender;
        candidates.push("Candidate 1");
        candidates.push("Candidate 2");
    }

    function vote(bytes32 candidate) public {
        require(!voters[msg.sender], "You have already voted.");
        require(candidate == candidates[0] || candidate == candidates[1], "Invalid candidate.");
        votesReceived[candidate]++;
        voters[msg.sender] = true;
    }

    function totalVotesFor(bytes32 candidate) public view returns (uint8) {
        require(candidate == candidates[0] || candidate == candidates[1], "Invalid candidate.");
        return votesReceived[candidate];
    }

    function changeOwner(address newOwner) public {
        require(msg.sender == owner, "You are not the owner.");
        owner = newOwner;
    }
}
