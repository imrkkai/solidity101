// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

contract Constant{

    // constant 常量 和 immutable 不变量
    // 状态变量声明为constant和immutable后，不能在初始化后更改其值，可以提升安全性和节省gas

    // 只有数值变量可以声明constant和immutable
    // string、bytes可以声明为constant，不能声明为immutable


    // constant
    // constant变量必须在声明时初始化，之后不能改变其值

    uint256 constant CONSTANT_NUM = 10;
    string constant CONSTANT_STRING = "0XAA";
    bytes32 constant CONSTANT_BYTE = "0XAA";
    address constant CONSTANT_ADDRESS = 0x0000000000000000000000000000000000000000;
    

    
    
    // immutable
    // immutable变量可以在声明时或构造函数中初始化, 更加linghuo 
    // 0.8.21之后，immutable不需要显示初始化，未显示初始化的将使用其类型的初始值
    // 若immutable变量既在声明时初始化，又在构造函数中初始化。则
    // 构造函数中的初始化会覆盖声明时的初始化


    uint256 public immutable IMMUTABLE_NUM = 111;
    // 以下变量的初始值为其类型的默认值
    address public immutable IMMUTABLE_ADDRESS;
    uint256 public immutable IMMUTABLE_BLOCK;
    uint256 public immutable IMMUTABLE_TEST;


    
    constructor() {
        // 可以使用全局变量对 IMMUTABLE_ADDRESS 变量进行初始化
        IMMUTABLE_ADDRESS = address(this);
        // 在构造函数中对 IMMUTABLE_BLOCK 变量进行赋值初始化
        IMMUTABLE_BLOCK = 10000;
        // 调用test函数对 IMMUTABLE_TEST 初始化
        IMMUTABLE_TEST = test();
    }

    function test() public pure returns(uint256) {
        //CONSTANT_NUM =100; // 尝试修改会报错
        // IMMUTABLE_BLOCK = 1000;
        uint256 what = 99;
        return (what);
    }

    


}