// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

contract Mapping {


    // 映射类型
    // 声明格式
    // mapping(_keyType => _valueType), 其中_keyType为键类型，_valueType为值类型

    mapping(uint => address) public idToAddress; // id映射到地址
    mapping(address => address) public swapPair; // 币对映射，地址到地址

    // 映射规则
    // 1. 映射的key只能是内置的值类型,不能是自定义的结构体，而值可以是内置类型，也可以是自定义结构体类型
    // 2. 映射打得存储位置必须是storage，因此可以用于合约的状态变量，函数中storage变量和libary函数的参数,
    //    不能用于public函数的参数和返回值，因为mapping记录的是一种关系
    // 3. 如果映射声明为public，那么会自动创建一个getter函数，可以通过key来查询对应vlaue
    // 4. 给映射新增的键值对语法为_Var[_key] = _Value。其中_Var映射的变量名, _Key和_Value为对应新增的键值对

    function writeMap(uint _Key, address _Value) public {
        idToAddress[_Key] = _Value; // id映射到地址
    }  

    // 映射的原理
    // 1. 映射不存在任务键信息，也没有length的信息
    // 2. 对育映射使用keccak256(h(key) . slot) 计算存取value的位置
    // 3. 因为Ethereum会定义所有未使用的空间为0，索引未赋值的键初始值都是各个类型的默认值,如uint的默认值是0.
    


}