// SPDX-License-Identifier: MIT
pragma solidity >= 0.8.0 < 0.9.0;

contract Arrays{
    uint[] public array;

    function remove(uint _index) public {
        require(_index < array.length, "El array no tiene tantos elementos");

        for (uint i = _index; i< array.length -1; i++){
            array[i] = array[i+1]; // asigna al indice i, el valor del array en el indice siguiente
        }
        array.pop();
    }

    function prueba() external {
        array = [1,2,3,4,5];
        remove(2); 

        assert(array[0] == 1);
        assert(array[1] == 2);
        assert(array[2] == 4);
        assert(array[3] == 5);

        assert(array.length == 4);
    }
}

contract ReemplazarUltimo{
    uint[] public array;

    function remove(uint _index) public {
        require(_index < array.length, "El array no tiene tantos elementos");

        uint lastItem = array[array.length-1];
        array[_index] = lastItem;
        array.pop();
    }

    function prueba() external {
        array = [1,2,3,4,5];
        remove(1);  // el array resultante = [1,5,3,4]

        assert(array[0] == 1);
        assert(array[1] == 5);
        assert(array[2] == 3);
        assert(array[3] == 4);

        assert(array.length == 4);
    }

}

