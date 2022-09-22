// SPDX-License-Identifier:MIT

pragma solidity ^0.8.0;



contract VotingSystem {

    struct Voter{

        uint weight ; // how many times the voter can vote : more than one if delegated
        bool voted ; // not double voting allowed. True for Already voted
        address delegate ;  // give own right to someone trusted
        uint voted_to ; // index of proposal voted to

    }

    mapping(address => Voter) voters ; 

    

    struct Proposal{
        bytes32 name ; 
        uint voteCount ; 

    }

    Proposal[] proposals ; 
    address manager ; 

    constructor(Proposal[] memory _proposal){

        manager = msg.sender ; 

        for(uint i = 0 ; i < _proposal.length ; i++){
            proposals.push(Proposal({
                name : _proposal[i].name ,
                voteCount : 0 
                            }));
        }
    }


    modifier OnlyManager(){

        require(msg.sender == manager , "This fucntion is only allowed to manager.");
        _; 
    }

    modifier NotVoted(){

        require(!voters[msg.sender].voted , "Already Voted");
        _;
    }

    modifier RightToVote(){
        require(voters[msg.sender].weight > 0 , "You have no right to vote");
        _;
    }


    function register(address _voter) OnlyManager NotVoted public {

        require(!(_voter == manager) ,  "Manager is not allowed to vote");
        require( voters[_voter].weight != 0 , "Voter already Registerd");
        voters[_voter].weight = 1 ; 

    }

    function delegate(address to) public RightToVote NotVoted {

        require(msg.sender != to , "You cannot delegate you vote to yourself.");

        require(voters[to].weight > 0, "The address you want to delegate your vote is not registered.");
        while(voters[to].delegate != address(0)){

            to = voters[to].delegate ; 
            require(msg.sender != to , "Delegation Loop Found. Delegation cannot be preformed.");

        }

        voters[msg.sender].delegate = to ; 
        voters[msg.sender].voted = true  ; 

        if(voters[to].voted){

            voters[msg.sender].voted_to = voters[to].voted_to ;
            proposals[voters[to].voted_to].voteCount = proposals[voters[to].voted_to].voteCount + 1  ;  
            
        }

        voters[to].weight = voters[to].weight  + voters[msg.sender].weight ; 

    }


    function vote(uint proposal_index) public RightToVote NotVoted {

        require(proposal_index < proposals.length, "Invalid proposal index.");

        voters[msg.sender].voted = true ; 
        voters[msg.sender].voted_to = proposal_index ; 

        proposals[proposal_index].voteCount += voters[msg.sender].weight; 
    }


    function SelectWinner() public view OnlyManager returns (uint){
        uint maxVote ; 
        uint winner ; 


        for(uint i = 0 ; i < proposals.length ; i++){

            if(proposals[i].voteCount > maxVote){
                maxVote = proposals[i].voteCount ; 
                
                winner = 1 ; 

            }
        }


        return winner ; 

    }

    function ShowWinnerName() public view OnlyManager returns (bytes32){

        return proposals[SelectWinner()].name ; 


    }

}