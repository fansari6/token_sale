// Code Your Own Cryptocurrency on Ethereum (Full)
// https://www.youtube.com/watch?v=XdKv5uwEk5A

// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract DappToken {
    // Name
    string public name = 'DApp Token';
    string public symbol = 'DAPP';
    string public standard = 'DApp Token v1.0';
    uint256 public totalSupply;
    
    //Symbol
    // Constructor
    // Set the total number of tokens
    // Read the total number of tokens

    event Transfer(
        address indexed _from, 
        address indexed _to, 
        uint256 _value
    );
    
    event Approval(
        address indexed _owner,
        address indexed _spender,
        uint256 _value
    );

    mapping(address => uint256) public balanceOf;

    // Allowance
    mapping(address => mapping(address => uint256)) public allowance;

    constructor(uint256 _initialSupply) public {
    // function DappToken(uint256 _initialSupply) public {
        balanceOf[msg.sender] = _initialSupply;
        totalSupply = _initialSupply;
        // Allocate the initial supply
    }

    // Transfer
    function transfer(address _to, uint256 _value) public returns (bool success) {
        require(balanceOf[msg.sender] >= _value);
        // Transfer the balance
        balanceOf[msg.sender] -= _value;
        balanceOf[_to] += _value;
        // Transfer Event
        emit Transfer(msg.sender, _to, _value);

        // Return a boolean
        return true;
    }

    // Delegated Transfer

    // Approve
    function approve(address _spender, uint256 _value) public returns (bool success) {
        // Allowance
        allowance[msg.sender][_spender] = _value;

        // Approval Event
        emit Approval(msg.sender, _spender, _value);

        return true;
    }
    
    // TransferFrom
    function transferFrom(address _from, address _to, uint256 _value) public returns (bool success) {
        
        // Require _from has enough tokens
        require(_value <= balanceOf[_from]);
        // Require allowance is big enough
        require(_value <= allowance[_from][msg.sender]);
        // Change the balance
        balanceOf[_from] -= _value;
        balanceOf[_to] += _value;
        // Update the allowance
        allowance[_from][msg.sender] -= _value;
        // Transfer Event
        emit Transfer(_from, _to, _value);
        // Return a Boolean
        return true;
    }
    
}