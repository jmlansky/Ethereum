// SPDX-License-Identifier: MIT
pragma solidity >= 0.8.20;

import "../Interfaces/IERC20.sol";
import "../Interfaces/IERC20Metadata.sol";

contract ERC20 is IERC20, IERC20Metadata {
    mapping(address => uint256) private _balances;
    mapping(address => mapping(address => uint256)) private _allowances;
    uint256 private _totalSupply;

    string private _name;
    string private _symbol;

    constructor(string memory name_, string memory symbol_) {
        _name = name_;
        _symbol = symbol_;
    }

    // Optional functions
    function name() external view override returns (string memory) {
        return _name;
    }

    function symbol() external view override returns (string memory) {
        return _symbol;
    }

    function decimals() external pure override returns (uint8) {
        return 18;
    }

    // Mandatory functions
    function totalSupply() external view override returns (uint256) {
        return _totalSupply;
    }

    function balanceOf(address owner) external view override returns (uint256) {
        return _balances[owner];
    }

    function transfer(address to, uint256 value) external override returns (bool) {
        address owner = msg.sender;
        _transfer(owner, to, value);
        return true;
    }

    function allowance(address owner, address spender) external view override returns (uint256) {
        return _allowances[owner][spender];
    }

    function approve(address spender, uint256 value) external override returns (bool) {
        address owner = msg.sender;
        _approve(owner, spender, value);
        return true;
    }

    function transferFrom(address from, address to, uint256 value) external override returns (bool) {
        address spender = msg.sender;
        _spendAllowance(from, spender, value);
        _transfer(from, to, value);
        return true;
    }

    function _transfer(address from, address to, uint256 value) internal {
        require(from != address(0), "ERC20: transfer from the zero address");
        require(to != address(0), "ERC20: transfer to the zero address");

        uint256 fromBalance = _balances[from];
        require(fromBalance >= value, "ERC20: transfer amount exceeds balance");

        unchecked {
            _balances[from] = fromBalance - value;
        }
        _balances[to] += value;

        emit Transfer(from, to, value);
    }

    function _approve(address owner, address spender, uint256 value) internal {
        require(owner != address(0), "ERC20: approve from the zero address");
        require(spender != address(0), "ERC20: approve to the zero address");

        _allowances[owner][spender] = value;
        emit Approval(owner, spender, value);
    }

    function _spendAllowance(address owner, address spender, uint256 value) internal {
        uint256 currentAllowance = _allowances[owner][spender];
        if (currentAllowance != type(uint256).max) {
            require(currentAllowance >= value, "ERC20: insufficient allowance");
            unchecked {
                _approve(owner, spender, currentAllowance - value);
            }
        }
    }
    

    function _mint(address _account, uint256 _amount) internal {
        require(_account != address(0), "ERC20: mint to zero address");
        _totalSupply += _amount;
        _balances[_account] += _amount;

        emit Transfer(address(0), _account, _amount);
    }

    function _burn(address _account, uint56 _amount) internal {
        require(_account != address(0), "ERC20: burn from zero address");

        uint256 accountBalance = _balances[_account];
        require(accountBalance < _amount, "ERC20: burn amount exceeds balance");
        
        _balances[_account] -= accountBalance - _amount;
        _totalSupply -= _amount;

        emit Transfer(_account, address(0), _amount);
    }


    function increaseTotalSupply (address _account, uint256 _amount) public {
        _mint(_account, _amount);
    }
}