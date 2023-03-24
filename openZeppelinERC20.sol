// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract myToken is ERC20{

    uint256 totalAmount = 10e18;

    constructor() ERC20("OliBaa" , "OBA") { 
        _mint(msg.sender , totalAmount);
    }
}

