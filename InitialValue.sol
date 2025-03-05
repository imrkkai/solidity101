// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

// 变量初始值
contract InitialValue {


    // 值类型的初始值
    /*
    boolean: false
    string: ""
    int: 0
    uint: 0
    enum: 枚举中的第一个元素
    address: 0x0000000000000000000000000000000000000000 (或 address(0))
    function
    internal: 空白函数
    external: 空白函数
    */


    bool public _bool;
    string public _string;
    int public _int;
    uint public _uint;
    address public _address;

    // 声明枚举
    enum ActionSet { Buy,Hold,Sell }

    ActionSet public _action;

    function fun1() internal {}

    function fun2() external {}


    // 引用类型的初始值
    /*
    映射mapping: 所有元素都为其默认值的mapping
    结构体struct: 所有成员设为其默认值的结构体
    数组array
    动态数组: []
    静态数组（定长）: 所有成员设为其默认值的静态数组
    */

    uint[8] public _staticArray; //所有成员设为其默认值的静态数组[0,0,0,0,0,0,0,0]
    uint[]  public _dynamicArray; // `[]`

    mapping (uint => address) public _mapping; // 所有元素都为其默认值的mapping

    struct Student {
        uint256 id;
        string name;
    }

    Student public student;


    // delete操作符 -让变量的值变为初始值

    bool public _bool2 = true;

    function deleteBool() external {
        delete _bool2;
    }


}