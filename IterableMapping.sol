// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 < 0.9.0;

contract IterableMapping {
    mapping (address => uint) public balances;
    mapping (address => bool) public inserted;

    address[] public keys;

    function set(address _key, uint _value) external {
        balances[_key] = _value;

        if (!inserted[_key]){
            inserted[_key] = true;
            keys.push(_key);
        }
    }

    function getSize() view external returns (uint){
        return keys.length;
    }

    function getFirst() view external returns (uint){
        return balances[keys[0]];
    }

    function getLast() view external returns (uint){
        return balances[keys[keys.length-1]];
    }

    function get(uint _index) view external returns (uint){
        return balances[keys[_index]];
    }
}