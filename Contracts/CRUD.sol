// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract UserCrud {
    address owner;

    struct User {
        uint256 id;
        string name;
        uint256 age;
        bool isActive; 
    }

    mapping(uint256 => User) private users;
    uint256 private nextId;

    event UserCreated(uint256 id, string name, uint256 age);
    event UserUpdated(uint256 id, string name, uint256 age);
    event UserDeleted(uint256 id);

    constructor () {
        nextId = 1;
        owner = msg.sender;
    }

    //Crear usuario
    function createUser(string memory _name, uint256 _age) public {
        
        users[nextId] = User(nextId, _name, _age, true);
        nextId++;

        emit UserCreated(nextId, _name, _age);        
    }

    //Obtener usuario
    function getUser(uint256 _id) public view returns (User memory){  
        require(_id > nextId, "User does not exist");
        require(users[_id].isActive, "Inactive User");

        return users[_id];   
    }

    // Obtener todos los usuarios
    function getAllActiveUsers() public view returns (User[] memory){
        uint256 count = 0;
        for(uint256 i = 0; i< nextId; i++) {
            if (users[i].isActive){
                count ++;
            }
        }

        User[] memory activeUsers = new User[](count);
        if (count == 0) {
            return activeUsers;
        }

        uint256 index = 0;
        for(uint256 i = 0; i< nextId; i++) {
            if (users[i].isActive){
                activeUsers[index] = users[i];
                index ++;
            }
        }

        return activeUsers;
    }

    //Actualizar usuario
    function updateUser(uint256 _id, string memory _name, uint256 _age) public {
        require(_id < nextId, "User does not exist");

        User storage user =  users[_id];
        user.name = _name;
        user.age = _age;

        emit UserUpdated(_id, _name, _age);        
    }

    //Eliminar usuario
    function deleteUser(uint256 _id) public {
        require(owner == msg.sender, "Unauthorized operation");        
        require(_id < nextId, "User does not exist");

        users[_id].isActive = false;

        emit UserDeleted(_id);        
    }
}