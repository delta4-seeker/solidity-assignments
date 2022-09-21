// SPDX-License-Identifier:MIT

pragma solidity ^0.8.0;

contract lottery{


    address manager ; 
    address[] public players ; 

    constructor() {

        manager = msg.sender ; 
    }

    modifier restricted {
        require(msg.sender == manager, "You have not permission to call this function");
        _;
    }

    modifier ManagerNotAllowed {
        require(msg.sender != manager , "Manager is not allowed to enter the lottery game.");
        _; 
    }

    function enter() public payable ManagerNotAllowed  {
      require(msg.value > .001 ether , "No sufficient ether");
            players.push(msg.sender);
      
    }

    

    function random() private restricted view returns (uint){
        return uint(keccak256(abi.encode(block.timestamp , players))) ; 

    }

    function SelectWinner() public restricted{
        uint index = random() % players.length ; 
        payable (players[index]).transfer(address(this).balance) ; 

        players = new address[](0);


    }


}