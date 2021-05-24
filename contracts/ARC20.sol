// SPDX-License-Identifier: MIT

pragma solidity >=0.7.0;

library NativeAssets {
    address constant balanceAddr = 0x0100000000000000000000000000000000000001;
    address constant transferAddr = 0x0100000000000000000000000000000000000002;

    function assetBalance(address addr, uint256 assetID) public returns (uint256) {
        (bool success, bytes memory data) = balanceAddr.call(abi.encodePacked(addr, assetID));
        require(success, "assetBalance failed");
        return abi.decode(data, (uint256));
    }
    
    function getBalance(uint256 assetID) public returns (uint256) {
        return assetBalance(msg.sender, assetID);
    }
    
    function assetCall(address addr, uint256 assetID, uint256 assetAmount, bytes memory callData) public returns (bytes memory) {
        (bool success, bytes memory data) = transferAddr.call(abi.encodePacked(addr, assetID, assetAmount, callData));
        require(success, "assetCall failed");
        return data;
    }
    
    function transferAsset(address addr, uint256 assetID, uint256 assetAmount) public returns (bytes memory) {
        return assetCall(addr, assetID, assetAmount, "");
    }
}

contract ARC20 {

    mapping (address => uint256) private _balances;
    mapping(address => mapping(address => uint256)) private _allowances;

    uint256 private _assetID;

    uint256 private _totalSupply;

    string private _name;
    string private _symbol;
    uint8 private _decimals;

    constructor(string memory name_, string memory symbol_, uint8 decimals_, uint256 assetID_) {
        _name = name_;
        _symbol = symbol_;
        _decimals = decimals_;
        _assetID = assetID_;
    }

    /**
     * @dev Returns the name of the token.
     */
    function name() external view returns (string memory) {
        return _name;
    }

    /**
     * @dev Returns the symbol of the token, usually a shorter version of the
     * name.
     */
    function symbol() external view returns (string memory) {
        return _symbol;
    }

    /**
     * @dev Returns the number of decimals used to represent the token.
     */
    function decimals() external view returns (uint8) {
        return _decimals;
    }

    /**
     * @dev Returns the total supply of `assetID` currently held by
     * this contract.
     */
    function totalSupply() external view returns (uint256) {
        return _totalSupply;
    }

    /**
     * @dev Returns the balance of `account` held in this contract.
     */
    function balanceOf(address account) external view returns (uint256) {
        return _balances[account];
    }

    // Withdrawal/Deposit functionality

    /**
     * @dev Acknowledges the receipt of some amount of an Avalanche Native Token
     * into the contract implementing this interface.
     */
    function deposit() external {
        uint256 updatedBalance = NativeAssets.assetBalance(address(this), _assetID);
        assert(updatedBalance > _totalSupply);
        uint256 depositAmount = updatedBalance - _totalSupply;

        _balances[msg.sender] += depositAmount;
        _totalSupply = updatedBalance;
        emit Deposit(msg.sender, depositAmount);
    }

    /**
     * @dev Emitted when `value` tokens are deposited from `depositor`
     */
    event Deposit(address indexed depositor, uint256 value);

    /**
     * @dev Acknowledges the receipt of some amount of an Avalanche Native Token
     * into the contract implementing this interface.
     */
    function depositTo(address to) external {
        uint256 updatedBalance = NativeAssets.assetBalance(address(this), _assetID);
        assert(updatedBalance > _totalSupply);
        uint256 depositAmount = updatedBalance - _totalSupply;

        _balances[to] += depositAmount;
        _totalSupply = updatedBalance;
        emit DepositTo(to, depositAmount);
    }

    /**
     * @dev Emitted when `value` tokens are deposited on behalf of `receiver`
     */
    event DepositTo(address indexed receiver, uint256 value);

    /**
     * @dev Withdraws `value` of the underlying asset to the contract
     * caller.
     */
    function withdraw(uint256 value) external {
        require(_balances[msg.sender] >= value, "insufficient funds for withdrawal");
        
        _balances[msg.sender] -= value;
        _totalSupply -= value;

        NativeAssets.transferAsset(msg.sender, _assetID, value);
        emit Withdrawal(msg.sender, value);
    }

    /**
     * @dev Emitted when `value` tokens are withdrawn to `withdrawer`
     */
    event Withdrawal(address indexed withdrawer, uint256 value);

    /**
     * @dev withdrawTo moves `value` from the account of `msg.sender` to the address
     * `to`.
     */
    function withdrawTo(address to, uint256 value) external {
        require(_balances[msg.sender] >= value, "insufficient funds for withdrawal");
        
        _balances[msg.sender] -= value;
        _totalSupply -= value;

        NativeAssets.transferAsset(to, _assetID, value);
        emit WithdrawTo(msg.sender, to, value);
    }

    /**
     * @dev Emitted when `value` tokens are withdrawn by `withdrawer`
     * and delivered to the address `to`.
     */
    event WithdrawTo(address indexed withdrawer, address indexed to, uint256 value);

    /**
     * @dev Returns the `assetID` of the underlying asset this contract handles.
     */
    function assetID() external view returns (uint256) {
        return _assetID;
    }

    event Transfer(address indexed from, address indexed to, uint256 value);

    function transfer(address to, uint256 value) external returns (bool success) {
        require(_balances[msg.sender] >= value, "insufficient balance for transfer");

        _balances[msg.sender] -= value;  // deduct from sender's balance
        _balances[to] += value;          // add to recipient's balance
        emit Transfer(msg.sender, to, value);
        return true;
    }

    event Approval(address indexed owner, address indexed spender, uint256 value);

    function approve(address spender, uint256 value)
        external
        returns (bool success)
    {
        _allowances[msg.sender][spender] = value;
        emit Approval(msg.sender, spender, value);
        return true;
    }

    function transferFrom(address from, address to, uint256 value)
        external
        returns (bool success)
    {
        require(value <= _balances[from], "from address has insufficient balance to transfer");
        require(value <= _allowances[from][msg.sender], "insufficient allowance granted to sender");

        _balances[from] -= value;
        _balances[to] += value;
        _allowances[from][msg.sender] -= value;
        emit Transfer(from, to, value);
        return true;
    }

    function allowance(address owner, address spender) external view returns (uint256) {
        return _allowances[owner][spender];
    }

    // ARC-20 must have a fallback function to avoid reverting when
    // an Avalanche Native Token is transferred to it via CALLEX.
    fallback() external payable {}

    // receive is included to avoid a compiler warning
    receive() external payable {}
}
