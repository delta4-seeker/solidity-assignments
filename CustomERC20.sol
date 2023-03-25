// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract Sikka{
    string public name = "Sikka" ; 
    string public symbol = " SIK" ; 
    uint public totalSupply = 100000; 
    uint public decimal = 18 ; 
    mapping(address => uint) public balance ; 
    mapping(address => mapping(address => uint)) public allowance ; 

    event Transfer(address _from , address _to , uint amount);
   // event Transfer(address sender , address receiveer , uint amount);

    event Approve(address _by , address _to , uint amount ); 
    // event Approve(address owner , address spender , uint amount ); 

    constructor(uint initialSupply){
        totalSupply = initialSupply ; 
        balance[msg.sender] = totalSupply ; 
    }

    function transfer(address _to , uint _amount ) public {
        require(balance[msg.sender] >= _amount , "Insufficient balance here");
        balance[msg.sender] -= _amount ; 
        balance[_to] += _amount ; 
        emit Transfer(msg.sender , _to , _amount ); 
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

}