// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;



contract ConstructorAndModifier{

    address public owner;

    // 构造函数 constructor 是一种特殊的函数
    // 每个合约可以定义一个，并在部署合约时自定运行一次, 可用来初始化合约的参数
    // 0.4.22 之前不能使用constructor, 而是使用与合约同名的函数
    constructor(address initialOwner) {
        owner = initialOwner;
    }

    /*
    //0.4.22 之前的构造函数
    function ConstructorAndModifier(address initialOwner) public {
        owner = initialOwner;
    }*/



    // 修饰器
    // 声明函数拥有的特性，减少代码用于
    // 主要应用场景是运行函数前检查
    modifier  onlyOwner {
        require(msg.sender == owner); // 检查调用者是否为owner地址
        _; // 如果是的话，继续运行函数主体；否则报错并revert交易
    }


    // 带有onlyOwner修饰符的函数，只能被owner地址调用
    // 这里定义了一个changeOwner函数，运行它可以改变合约的owner，但是由于onlyOwner修饰符的存在，
    // 只有原先的owner可以调用，别人调用就会报错。这也是最常用的控制智能合约权限的方法。
    function changeOwner(address _newOwner) external onlyOwner {
        owner = _newOwner;
    }

    // OpenZeppelin的Ownable标准实现
    // OpenZeppelin是一个维护Solidity标准化代码库的组织，其Ownable标准实现如下：
    // https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol
    


}