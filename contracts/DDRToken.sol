// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

contract DDRToken {
    event Transfer(address indexed _from, address indexed _to, uint256 _value);
    event Approval(address indexed _owner, address indexed _spender, uint256 _value);

    string public name;
    string public symbol;
    uint8 public decimals;
    uint public totalSupply;
    
    mapping(address => uint) public balanceOf;
    mapping(address => mapping(address => uint)) public allowance;

    constructor() {
        name = "DDRToken";
        symbol = "DDRT";
        decimals = 18;
        totalSupply = 10000000000000;
        balanceOf[msg.sender] += totalSupply;
    }

    function transfer(address _to, uint _value) public returns (bool) {
        require(balanceOf[msg.sender] >= _value, "insufficient balance");
        require(_to != address(0), "transfer to the zero address");

        balanceOf[_to] += _value;
        balanceOf[msg.sender] -= _value;
        emit Transfer(msg.sender, _to, _value);
        return true;
    }

    function approve(address _spender, uint _value) public returns (bool) {
        allowance[msg.sender][_spender] = _value;
        emit Approval(msg.sender, _spender, _value);
        return true;
    }

    function transferFrom(address _from, address _to, uint _value) public returns (bool) {
        require(balanceOf[_from] >= _value, "insufficient balance");
        require(allowance[_from][msg.sender] >= _value, "insufficient allowance");
        require(_to != address(0), "transfer to the zero address");

        balanceOf[_from] -= _value;
        balanceOf[_to] += _value;
        allowance[_from][msg.sender] -= _value;
        emit Transfer(_from, _to, _value);
        return true;
    }
}