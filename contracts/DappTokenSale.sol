// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

import './DappToken.sol';

contract DappTokenSale {
    address admin;
    DappToken public tokenContract;
    uint256 public tokenPrice;
    uint256 public tokensSold;

    event Sell(address _buyer, uint256 _amount);

    constructor(DappToken _tokenContract, uint256 _tokenPrice) public {

        // Assign on admin
        admin = msg.sender;
        
        // Token Contract
        tokenContract = _tokenContract;

        // Token Price
        tokenPrice = _tokenPrice;
        
    }

    // Multiply
    function multiply(uint x, uint y) internal pure returns (uint z) {
        require(y == 0 || (z = x * y) / y == x);
    }

    function buyTokens(uint256 _numberOfTokens) public payable {

        // Require that value is equal to tokens
        require(msg.value == multiply(_numberOfTokens, tokenPrice));

        // Require that the contract has enough tokens
        require(tokenContract.balanceOf(address(this)) >= _numberOfTokens);

        // Require that a transfer is succesfull
        require(tokenContract.transfer(msg.sender, _numberOfTokens));
        
        // Keep track of tokensSold
        tokensSold += _numberOfTokens;

        // Trigger Sell Event
        emit Sell(msg.sender, _numberOfTokens);

    }
        // Ending Token DappTokenSale
    function endSale() public {
        // Require admin
        require(msg.sender == admin);
        // Transfer remaining dapp tokens to admin
        require(tokenContract.transfer(admin, tokenContract.balanceOf(address(this))));
        // Destroy contract
        // selfdestruct(admin);
        payable(admin).transfer(address(this).balance);
    }
}