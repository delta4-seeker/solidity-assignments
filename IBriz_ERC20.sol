// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

contract Ibriz{
    string public name = "Ibriz" ; 
    string public symbol = " BRIZ" ; 
    uint public totalSupply; 
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