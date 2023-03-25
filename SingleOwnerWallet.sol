// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.4.22 <0.9.0;

/// @title A contract for demonstrate Wallet Smart Contract
/// @author Jitendra Kumar
/// @notice For now, this contract just show how to depositing money into the Owner's account instead of the contract account.
contract wallet{

	address payable public owner ; 

	constructor() {
		owner = payable(msg.sender) ; 
	}

	modifier onlyOwner(){
		require(msg.sender == owner , "Not owner of this wallet");
		_;
	}

	function withdraw(address payable _to , uint256 _amount ) payable public onlyOwner{
		_to.transfer(_amount) ; 
	}
	function depositeAmount() public payable {
	}

}
