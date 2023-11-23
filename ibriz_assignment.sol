// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.8.22;

contract Storage {
// declear a variable
    uint256 ibriz_number ; // a simple variable to store a number permanently

// this function takes a interger and stores it in the variable
    function storeNumber(uint256 num)  public {
        ibriz_number = num;
    }

// this function returns the stored value in the variable
    function retrieveNumber() public view returns (uint256){
        return ibriz_number;
    }
}