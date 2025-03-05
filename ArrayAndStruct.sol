// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

contract ArrayAndStruct{
    // 数组- array
    // 定长数组 - 声明时指定长度
    // 不定长数组 - 声明时不指定长度


    uint[8] array1;
    bytes1[5] array2;
    address[100] array3;

    uint[] array4;
    bytes1[] array5;
    address[] array6;

    // bytes是数组，但比较特殊，声明是不用[],比bytes1[]省gas
    bytes array7;


    // 使用[]初始化定长数组，数组中元素的类型 以第一个数组元素的类型微赚
    // 如：[1,2,3]，数组里面元素的类型为uint8。
    // 如果一个值没有指定类型，则根据上下文推断出元素类型，默认是最小单位的类型。所以这里是uint8
    // 而[uint(1),2,3]，第一元素指定了uint类型，所有数组中所有的元素都是uint类型.


    // 如果是创建动态数组，需要一个一个进行赋值
    function arrayInit() public pure{
        uint[] memory a = new uint[](3);
        a[0] = 1;
        a[1] = 2;
        a[2] = 3;  //
    }
    
    
    function arrayTest() external pure{
        // 对于memory修饰的的动态数组，可以使用new来创建，但必须指定长度
        // memory动态数组
        //uint[] memory array8 = new uint[](5);
        //bytes memory array9 = new bytes(9);

    }

    function arrayTest1() external  pure {
        arrayTest2([uint(1),2,3]);
    }


    function arrayTest2(uint[3] memory _array) public  pure returns(uint) {
        // TODO 
        return uint(0);
    }


    function arrayMember() public returns(uint[] memory){
        uint[3] memory arr = [uint(1),2,3];

        array4 = arr;

        array4.push();
        array4.push(4);

        // uint[] memory arr2;
        // arr2 = array4;
        // arr2 = arr; // 为什么会报错? 内存数组不能通过引用直接赋值给另一个内存数组
        return array4;

    }



    // 结构体struct
    
    // 定义
    struct User{
        uint id;
        string name;    
    }

    // 声明一个结构体变量
    User user;
    // 声明结构体变量并初始化
    User user1 = User(1,"xiaoming");

    function initUser() public view returns(User memory){
        // 结构体赋值， 创建引用
        //User storage _user = user;
        User memory _user = user;
        _user.id = 2019;
        _user.name = "xiaohong";
        return user;
    }


    function initUser2() public returns(User memory){
        // 直接引用状态变量
        user.id = 100;
        user.name = "user2";
        return user;
    }


    function initUser3() public pure returns(User memory){
        // 使用构造函数
        return User (uint(4),"user3");
    }

    function initUser4() public returns(User memory){
        user = User({id: 100, name: "user4"});
        return user;
    }



}