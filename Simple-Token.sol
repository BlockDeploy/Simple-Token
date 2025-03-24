// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleToken {
    // Token name
    string public name;
    // Token symbol
    string public symbol;
    // Number of decimal places
    uint8 public decimals;
    // Total supply of tokens
    uint256 public totalSupply;
    // Balances of each address
    mapping(address => uint256) public balanceOf;
    // Allowed amounts for spenders
    mapping(address => mapping(address => uint256)) public allowance;
    // Contract owner
    address public owner;
    // Paused state
    bool public paused;

    // Event for token transfers
    event Transfer(address indexed from, address indexed to, uint256 value);
    // Event for approval of spenders
    event Approval(address indexed owner, address indexed spender, uint256 value);
    // Event for pausing/unpausing
    event Paused(address account);
    event Unpaused(address account);

    // Modifier to restrict to owner
    modifier onlyOwner() {
        require(msg.sender == owner, "Not owner");
        _;
    }

    // Modifier to check if not paused
    modifier whenNotPaused() {
        require(!paused, "Contract is paused");
        _;
    }

    // Constructor to initialize the token
    constructor(
        string memory _name,
        string memory _symbol,
        uint8 _decimals,
        uint256 _initialSupply
    ) {
        name = _name;
        symbol = _symbol;
        decimals = _decimals;
        totalSupply = _initialSupply * 10**uint256(_decimals);
        balanceOf[msg.sender] = totalSupply;
        owner = msg.sender;
        paused = false;
        emit Transfer(address(0), msg.sender, totalSupply);
    }

    // Function to transfer tokens
    function transfer(address to, uint256 value) public whenNotPaused returns (bool) {
        require(to != address(0), "Invalid address");
        require(balanceOf[msg.sender] >= value, "Insufficient balance");
        balanceOf[msg.sender] -= value;
        balanceOf[to] += value;
        emit Transfer(msg.sender, to, value);
        return true;
    }

    // Function to approve a spender
    function approve(address spender, uint256 value) public whenNotPaused returns (bool) {
        allowance[msg.sender][spender] = value;
        emit Approval(msg.sender, spender, value);
        return true;
    }

    // Function to transfer tokens on behalf of another address
    function transferFrom(address from, address to, uint256 value) public whenNotPaused returns (bool) {
        require(from != address(0), "Invalid from address");
        require(to != address(0), "Invalid to address");
        require(balanceOf[from] >= value, "Insufficient balance");
        require(allowance[from][msg.sender] >= value, "Insufficient allowance");
        balanceOf[from] -= value;
        balanceOf[to] += value;
        allowance[from][msg.sender] -= value;
        emit Transfer(from, to, value);
        return true;
    }

    // Function to burn tokens (reduce total supply)
    function burn(uint256 value) public whenNotPaused returns (bool) {
        require(balanceOf[msg.sender] >= value, "Insufficient balance");
        balanceOf[msg.sender] -= value;
        totalSupply -= value;
        emit Transfer(msg.sender, address(0), value);
        return true;
    }

    // Function to pause the contract (only owner)
    function pause() public onlyOwner {
        require(!paused, "Already paused");
        paused = true;
        emit Paused(msg.sender);
    }

    // Function to unpause the contract (only owner)
    function unpause() public onlyOwner {
        require(paused, "Not paused");
        paused = false;
        emit Unpaused(msg.sender);
    }
}