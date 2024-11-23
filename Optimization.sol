// SPDX-License-Identifier: MIT
pragma solidity >= 0.8.0;

/*
    - Usar calldata
    - cargar variables de estado en memoria
    - cortocircuito
    - cache de longitud de arrays
    - cargar elementos del array en memoria
*/

// RESULTADOS DESPUES DE APLICAR TODAS LAS TECNICAS DE REDUCCION DE GAS
// 1) input array [1,4,7,8,9,100] => transaction cost = 49738 gas
// 2) usando "calldata" en lugar de "memory" en la firma del metodo = 48010 gas
// 3) usando variables de estado en memoria = 47777 gas
// 4) usando cortocircuito = 47465 gas
// 5) usando cache de longitud de array = 47429 gas
// 6) usando elementos del array en memoria = 47261 gas

contract GasRefactor{
    uint public total;

    // 1) funcion inicial
    // function sumarConMemory(uint[] memory nums) external {
    //     for (uint i = 0; i < nums.length; i++){
    //         bool esPar = nums[i] %2 == 0;
    //         bool esMenor99 = nums[i] < 99;

    //         if (esPar && esMenor99){
    //             total+= nums[i];
    //         }
    //     }
    // }

    // // 2) cambiar "memory" por "calldata" en el parametro
    // function sumarConCalldata(uint[] calldata nums) external {
    //     for (uint i = 0; i < nums.length; i++){
    //         bool esPar = nums[i] %2 == 0;
    //         bool esMenor99 = nums[i] < 99;

    //         if (esPar && esMenor99){
    //             total+= nums[i];
    //         }
    //     }
    // }

    // 3) usar variables de estado 
    // function sumarConVblesDeEstado(uint[] calldata nums) external {
    //     uint _total = total; // usar esta variable local
    //     for (uint i = 0; i < nums.length; i++){
    //         bool esPar = nums[i] %2 == 0;
    //         bool esMenor99 = nums[i] < 99;

    //         if (esPar && esMenor99){
    //             _total+= nums[i]; // actualizar variable local
    //         }
    //     }
    //     total = _total; // actualizar variable global
    // }

    // // 4) usar cortocircuito
    // function sumarConCortocircuito(uint[] calldata nums) external {
    //     uint _total = total; 
    //     for (uint i = 0; i < nums.length; i++){            
    //         if (nums[i] %2 == 0 && nums[i] < 99){ // reemplazo las variables usadas
    //             _total+= nums[i]; 
    //         }
    //     }
    //     total = _total;
    // }

    // 5) usar cache de longitud de arrays
    // function sumarConCacheDeLongitud(uint[] calldata nums) external {
    //     uint _total = total; 
    //     uint _longitudArray = nums.length; // usar variable local para guardar longitud de array
    //     for (uint i = 0; i < _longitudArray; i++){            
    //         if (nums[i] %2 == 0 && nums[i] < 99){ 
    //             _total+= nums[i]; 
    //         }
    //     }
    //     total = _total;
    // }

    // 6) guardar los elementos del array en memoria
    function sumarConCacheDeArray(uint[] calldata nums) external {
        uint _total = total; 
        uint _longitudArray = nums.length; 
        for (uint i = 0; i < _longitudArray; i++){    
            uint num = nums[i]; // usar variable local para no acceder al indice del array
            if (num %2 == 0 && num < 99){ 
                _total+= num; 
            }
        }
        total = _total;
    }
}