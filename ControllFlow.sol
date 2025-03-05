// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

contract ControllFlow{


    // 控制流
    function ifelseTest(uint256 _number) public pure returns(bool){
        if(_number == 0){
            return (true);
        }else{
            return (false);
        }

        // if, if else if else变体
    }


    function forLoopTest() public pure returns(uint) {
        uint sum = 0;
        for(uint i =0; i < 10; i++) {
            sum += 1;
        }

        return (sum);
    }


    function whileTest() public pure returns(uint) {
        uint sum = 0;
        uint i = 0;

        while(i < 10) {
            sum += i;
            i++;
        }

        return (sum);
    }


    function dowhileTest() public pure returns(uint){
        uint sum = 0;
        uint i = 0;
        do{
            sum += i;
            i++;
        }while(i < 10);

        return (sum);
    }

    // 三元运算符
    function ternaryTest(uint256 x, uint256 y) public pure returns(uint256) {
        return x >= y ? x : y;
    }


    // continue -跳过当前循环，进入下一次循环
    // break - 跳出循环

    function insertSort(uint[] memory a) public pure returns(uint[] memory) {
        for (uint i = 1; i < a.length; i++) {
            uint temp = a[i];
            uint j = i;
            while(j >= 1 && a[j-1] > temp) {
                a[j] = a[j-1];
                j--;
            }
            a[j] = temp;
        }
        return a;
    }


}