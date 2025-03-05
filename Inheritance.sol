// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

// 继承 - 简单继承、多重继承，修饰器（Modifier）和构造器(Constructor)继承
// 继承是面向对象很重要的组成部分，可以显著减少重复代码
// 如果把合约看做是对象的话，Solidity也是面向对象编程的，也支持继承

// 规则
// - virtual: 父合约中的函数，如果希望字合约重写需要加上virtual关键字
// - override: 子合约重写了父合约中的函数，需要加上override关键字

// 用override修饰public变量，会重写于变量同名的getter函数, 如:
// mapping(address => uint256) public override balanceOf;


contract BaseInherit {

    event Log(string msg);

    function hello() public virtual {
        emit Log("hello world");
    }

    function say() public virtual {
        emit Log("saying");
    }


    function sing() public virtual {
        emit Log("sing");
    }

}

// 简单继承
// 继承了BaseInherit, 并重写了hello方法
contract Inheritance is BaseInherit  {

    
    function hello() public virtual override  {
        emit Log("Hello, I am Inhertance");
    }

    function run() public virtual {
        emit Log("run run!!");
    }


}

// 多重继承
// 继承时，is后面的要继承的合约，要按照备份先后顺序排，如要写成：BaseInherit, Inheritance （不能写成：Inheritance, BaseInherit）
// 如果一个函数存在于多个继承的合约力，必须要重写
// 重写多个父合约中都重名的函数时，override关键字后面要加上父合约的名字
contract MyContract is BaseInherit, Inheritance{

    function hello() public virtual override(BaseInherit, Inheritance){
        emit Log("Hello, I am MyContract");    
    }


}



// 修饰器继承
// solidity中修饰器（Modifier）同样可以继承，用法和函数类似，在相应的地方加上virtual和override即可

contract ModifierBase {
    modifier exactDivBy2And3(uint _a) virtual {
        require(_a % 2 == 0 &&_a % 3 == 0);
        _;
    }
}


contract ModifierInherit is ModifierBase{

    //Identifier合约可以直接在代码中使用父合约中的exactDividedBy2And3修饰器，也可以利用override关键字重写修饰器：
    // 重写修饰器
    modifier exactDivBy2And3(uint _a) override  {
        _;
        require(_a % 2 == 0 &&_a % 3 == 0);
    }


    function getExactDivBy2And3(uint _dividend) 
    public exactDivBy2And3(_dividend) pure returns(uint, uint) {
        return getExactDivBy2And3WithourModifier(_dividend);
    }

    function getExactDivBy2And3WithourModifier(uint _dividend) public pure returns(uint, uint) {
        uint div2 = _dividend / 2;
        uint div3 = _dividend / 3;
        return (div2, div3);
    }

}

// 构造函数继承
// 子合约有两种方法继承父合约的构造函数，

abstract contract ParentContract{
    uint public a;
    constructor(uint _a) {
        a = _a;
    }
}

// 1. 在继承时声明父合约的构造函数的参数
contract ChildContract is ParentContract(100) {

}

// 2. 在子合约的构造函数中声明构造函数的参数,
contract ChildContract1 is ParentContract{
    constructor(uint _c) ParentContract(_c * 2) {

    }
}



// 调用父合约中的函数
// 子合约有两种方式可以调用父合约的函数，直接调用和利用super关键字调用

// 1. 直接调用： 子合约可以直接用父合约.函数名() 的方式调用父合约的函数

contract CallParentContract is MyContract {
    function callParentHello() public {
        //MyContract.hello();
        Inheritance.hello();
    }

    function callSuperFun() public {
        // 将调用最近的父合约函数
        super.hello();
    }

}


// 钻石继承
// 钻石继承（菱形继承）是指一个派生类同时有两个或两个以上的基类

// 在多重继承+菱形继承的链条上使用super关键字是，需要注意的是使用super会
// 调用继承链条上的每一个合约的相关函数，而不只是调用最近的父合约

/* 继承树：
  God
 /  \
Adam Eve
 \  /
people
*/

contract God {
    event Log(string msg);
    function foo() public virtual {
        emit Log('Goo.foo called');
    }

    function bar() public virtual {
        emit Log('Goo.bar called');
    }
}


contract Adam is God {
    function foo() public virtual override {
        emit Log('Adam.foo called');
        super.foo();
    }

    function bar() public virtual override {
        emit Log('Adam.bar called');
        super.bar();
    }
}

contract Eve is God {
    function foo() public virtual override {
        emit Log("Eve.foo called");
        super.foo();
    }

    function bar() public virtual override {
        emit Log("Eve.bar called");
        super.bar();
    }
}

contract People is Adam, Eve {
    function foo() public override(Adam, Eve) {
        emit Log('People.foo called');
        super.foo();
    }

    function bar() public override(Adam, Eve) {
        emit Log('people.foo called');
        super.bar();
    }
}


// 调用合约people中的supper.bar会依次调用Eve，Adam，最后是God合约的bar函数
// 虽然Eve，Adam都是God的子合约，但整个过程中God合约只会被调用一次
// 原因是借鉴了python的方式
// 强制一个又基类组成的DAG（有向无环图）, 使其保证了一个特定的顺序

