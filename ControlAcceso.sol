// SPDX-License-Identifier: MIT
pragma solidity >= 0.8.0 < 0.9.0;

contract ControlAcceso{
    event RoleAssigned(bytes32 indexed  role, address indexed account);
    event RoleRemoved(bytes32 indexed  role, address indexed account);

    mapping (bytes32 => mapping (address => bool)) public roles;
    
    //ADMIN HASH: 0xdf8b4c520ffe197c5343c6f5aec59570151ef9a492f2c624fd45ddde6135ec42
    bytes32 private constant ADMIN = keccak256(abi.encodePacked("ADMIN")); 

    //USER HASH: 0x2db9fd3d099848027c2383d0a083396f6c41510d7acfd92adc99b6cffcf31e96
    bytes32 private constant USER = keccak256(abi.encodePacked("USER"));

    modifier onlyAdmin(bytes32 _role){
        require(roles[_role][msg.sender], "User not allowed");
        _;
    }

    constructor(){
        _assignRole(ADMIN, msg.sender);
    }


    function _assignRole(bytes32 _role, address _account) internal {
        roles[_role][_account] = true;
        emit RoleAssigned(_role, _account);
    }

    function _removeRole(bytes32 _role, address _account) internal {
        roles[_role][_account] = false;
        emit RoleRemoved(_role, _account);
    }

    // only the Admin can assign roles
    function AssignRole(bytes32 _role, address _account) external onlyAdmin(ADMIN){
        _assignRole(_role, _account);
    }

    // only the Admin can assign roles
    function RemoveRole(bytes32 _role, address _account) external onlyAdmin(ADMIN){
        _removeRole(_role, _account);
    }
}