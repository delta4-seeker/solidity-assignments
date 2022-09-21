
// SPDX-License-Identifier:MIT
pragma solidity ^0.8.0 ; 

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol" ; 
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC721/ERC721.sol" ; 

contract WolfNFTContract is Ownable, ERC721("wolfNFT" , "WLF"){


    uint TokenId ; // unique identifier of each token initializing with 0

    struct TokenMetaData{   // to keep tokenid , timestamp and tokenuri in one place to track ownership record 

        uint tokenID ; 
        uint timestamp ; 
        string TokenURI ; 
    }

    mapping(address => TokenMetaData[]) public ownershipRecord ;

function mintToken(address recipient) onlyOwner public{

        require(owner() != recipient , "Recipient cannot be the owner of this contract.") ; 

        _safeMint(recipient , TokenId) ; 

        ownershipRecord[recipient].push(TokenMetaData(TokenId , block.timestamp , "https://d1don5jg7yw08.cloudfront.net/800x800/nft-images/20220315/Wolf_Canidae_3_1647335847713.jpeg"));

        TokenId = TokenId + 1  ; 
}

}