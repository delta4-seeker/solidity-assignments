//SPDX-License-Identifier: MIT

pragma solidity ^0.8.18 ; 

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/ERC20.sol" ; 

contract WrappedEther is ERC20{

    constructor() ERC20("WaEther" , "WETH") {

    }

    function Deposite() public payable {
        require(msg.value > 0 , "Please deposite ether.");
        _mint(msg.sender , msg.value) ; 
    }

    function Withdraw( uint amount ) public {
        // require(balanceOf(msg.sender) >= amount , "Insuff balance.");
        _burn(msg.sender , amount);
        payable(msg.sender).transfer(amount);
    }

}