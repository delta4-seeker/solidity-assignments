// SPDX-License-Identifier: MIT
//Users of software using an MIT License are permitted to use, copy, modify, 
//merge publish, distribute, sublicense and sell copies of the software.  

pragma solidity ^0.8.18;

contract Ibriz{
    string public name = "Ibriz" ; 
    string public symbol = " BRIZ" ; 
    uint public totalSupply; 
    uint public decimal = 18 ; 
    mapping(address => uint) public balance ; 
    mapping(address => mapping(address => uint)) public allowance ; 

    event Transfer(address _from , address _to , uint amount); 

//Placing the “indexed” keyword in front of a parameter 
//name will store it as a topic in the log record.

    event Approve(address _by , address _to , uint amount ); 

    constructor(uint initialSupply){
        totalSupply = initialSupply ; 
        balance[msg.sender] = totalSupply ; 
        emit Transfer(address(0) , msg.sender , initialSupply ); 
    }
//For a token with 18 decimal places, 1 token is equivalent to 10^18
//  of its smallest unit. Therefore, to send 2.5 tokens, it would calculate as:
// 2.5*10^18

    function transfer(address _to , uint _amount ) public {
        require(balance[msg.sender] >= _amount , "Insufficient balance here");
        balance[msg.sender] -= _amount ; 
        balance[_to] += _amount ; 
        emit Transfer(msg.sender , _to , _amount ); 
        //after every update in the balance, there should be an event emitted.
    }

    function transferFrom(address _from, address _to , uint _amount ) public {
        require(allowance[_from][msg.sender] >= _amount , "Amount not approved");
        require(balance[_from] >= _amount, "Insufficient balance.");
        balance[_from] -= _amount ; 
        balance[_to] += _amount ; 
        allowance[_from][ msg.sender] -= _amount ; 
        emit Transfer(_from , _to , _amount);
    }

    function approve(address _to , uint _amount) public {
        require(balance[msg.sender] >= _amount , "Insufficient amount");
        allowance[msg.sender][_to] += _amount ; 
        emit Approve(msg.sender , _to , _amount) ; 
    }

    function mint(address _to, uint256 _amount) public {
        totalSupply += _amount;
        balance[_to] += _amount;
        emit Transfer(address(0), _to, _amount);
    }

    function burn(uint256 _amount) public {
        require(balance[msg.sender] >= _amount, "Insufficient balance");
        totalSupply -= _amount;
        balance[msg.sender] -= _amount;
        emit Transfer(msg.sender, address(0), _amount);
    }

}