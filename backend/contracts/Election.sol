// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

contract Election
{
    // struct candidate
    struct Candidate
    {
        uint    id;
        string  name;
        uint    voteCount;
    }
    // candidate count
    uint public candidatesCount;
    // mappings
    mapping (uint    => Candidate) public candidates; //mapping to list the candidates
    mapping (address => bool)      public votedornot;//mapping to know if a person has voted 
    
    // events 
    //event to be broadcast when a person has voted 
    event Voted 
    (
        uint    id, 
        string  name, 
        uint    voteCount
    );
    // constructor
    constructor()
    {
        //The initial code
        addCandidates("Donald Trump");
        addCandidates("Barack Obama");
    }

    //Function to add candidates
    function addCandidates(string memory name) private  
    {
        candidatesCount++;
        candidates[candidatesCount] = Candidate(candidatesCount, name, 0);
    }

    function Vote(uint _id) public 
    {
        //the person has not voted again
        require(!votedornot[msg.sender], "you have voted for tha participant"); //The bool should be false
        //the id that the person has input is available
        require(candidates[_id].id != 0, "The id doesn't exist");
        // increases the vote count of the person who was voted
        candidates[_id].voteCount+=1;
        //change the bool to true for the person who has voted
        votedornot[msg.sender] = true; 
        //emit the event
        emit Voted(_id, candidates[_id].name, candidates[_id].voteCount);
    }
}