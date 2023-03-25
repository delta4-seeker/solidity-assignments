///SPDX-License-Identifier: MIT

pragma solidity ^0.8.18 ; 
import "./erc20FromInterface.sol" ; 

contract TokenSale{
    Sikka sikkaContract; 
    uint public price ; 
    address payable public admin ; 

    constructor(Sikka _sikkaContract , uint _price) {
        sikkaContract = _sikkaContract ; 
        price = _price ; 
        admin = payable(msg.sender ); 
    }

    function buyToken(uint amount) public payable {
        // sikkaContraact.balance[this] gives the amount of token transfered by seller to this contract.
        require( sikkaContract.allowance(admin , address(this)) >= amount , "Insufficient Token for sale.");
        require(msg.value >= price*amount , "Insufficient funds.");
        sikkaContract.transferFrom(admin , msg.sender , amount) ; 
    }

    function endSales() public {
        require(msg.sender == admin , " You are not admin");
        admin.transfer(address(this).balance);
    }
}