// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

interface IERC20 {
    function decimals() external pure returns(uint); 

    function totalSupply() external view returns(uint);

    function balanceOf(address account) external view returns(uint);

    function transfer(address to, uint amount) external;

    function allowance(address owner, address spender) external view returns(uint);

    function approve(address spender, uint amount) external;

    function transferFrom(address sender, address recipient, uint amount) external;

    event Transfer(address indexed from, address indexed to, uint amount);

    event Approval(address indexed owner, address indexed to, uint amount);
}

contract TinToken is IERC20 {
    address public thisOwner;
    uint startSupply = 1000000000;
    uint totalTokens;
    mapping(address => uint) balances;
    mapping(address => mapping(address => uint)) allowances;
    string public name = "TinToken";
    string public symbol = "TTN";

    constructor() {
        thisOwner = msg.sender;
        mint(startSupply * 10 ** decimals());
    }

    modifier enoughTokens(address _from, uint _amount) {
        require(balanceOf(_from) >= _amount, "Not enough tokens!");
        _;
    }

    modifier onlyOwner {
        require(msg.sender == thisOwner, "You are not an owner!");
        _;
    }

    function decimals() public override pure returns(uint) {
        return 18;
    }

    function totalSupply() public override view returns(uint) {
        return totalTokens;
    }

    function balanceOf(address account) public override view returns(uint) {
        return balances[account];
    }

    function transfer(address to, uint amount) external override enoughTokens(msg.sender, amount) {
        balances[msg.sender] -= amount;
        balances[to] += amount;
        emit Transfer(msg.sender, to ,amount);
    }

    function allowance(address owner, address spender) external override view returns(uint) {
        return allowances[owner][spender];
    }

    function approve(address spender, uint amount) external override {
        allowances[msg.sender][spender] = amount;
        emit Approval(msg.sender, spender, amount);
    }

    function transferFrom(address sender, address recipient, uint amount) public override enoughTokens(sender, amount) {
        allowances[sender][msg.sender] -= amount;
        balances[sender] -= amount;
        balances[recipient] += amount;
        emit Transfer(sender, recipient, amount);
    }

    function mint(uint amount) public onlyOwner {
        balances[msg.sender] += amount;
        totalTokens += amount;
        emit Transfer(address(0), msg.sender, amount);
    }

    function burn(uint amount) public enoughTokens(msg.sender, amount) onlyOwner {
        balances[msg.sender] -= amount;
        totalTokens -= amount;
        emit Transfer(msg.sender, address(0), amount);
    }

    fallback() external payable{

    }

    receive() external payable{

    }
}