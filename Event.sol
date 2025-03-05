// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

contract Event{
    
    // 定义_balance映射变量，记录每个地址的持币数量
    mapping(address => uint256) public _balances;

    // solidity中的事件是EVM上日志的抽象，具有两个特点
    // 响应：应用程序（ethers.js）可以通过RPC接口订阅和监听事件，并在前端做响应
    // 经济：事件是EVM上比较经济的存储数据的方式，每个大概消耗2000gs，相比之下，链上存储一个新变量至少需要20000个gas

    // 声明事件
    // event 事件名(事件需要记录的变量类型和参数)
    // 以ERC20代币合约的Transfer事件为例:
    // Transfer事件同记录了3个变量from，to和value。分别对应代币的转账地址，接收地址和转账shul,
    // 其中from和to签名带有indexed关键字，表示他们会保存在以太坊虚拟机日志的topics中，方便之后检索
    event Transfer(address indexed from, address indexed to, uint256 value);


    // 释放事件
    // 可以在函数中释放事件
    // 下面的例子中，每次调佣_transfer函数进行转账操作时，都会释放Transfer事件，并记录响应的变量
    function _transfer(
        address from,
        address to,
        uint256 amount
    ) external {
        _balances[from] = 1000000; // 给转账地址一些初始代币
        _balances[from] -= amount; // 从from地址减去转账数量
        _balances[to] += amount; // 给to地址增加转账shul 

        // 释放时间
        emit Transfer(from, to, amount);
    }


    // 虚拟机日志Log
    // 以太坊虚拟机EVM用日志Log来存储Solidity事件，每条日志记录都包含主题topics和数据data两部分

    // 主题topics
    // 日志的第一部分是主题数组, 用于描述事件，长度不能超过4.
    // 第一个元素是事件的签名（哈希）, 对于上面的Transfer事件，它的事件签名就是
    // 除了事件哈希外，主题还可以包含至多三个indexed参数，就是Transfer事件中的from和to
    // indexed标记的参数可以理解为检索时间的索引键，方便之后检索，
    // 每个indexed参数的大小固定为256比特，如果参数太多了，就会自动计算哈希存储在主题中
    
    // 根据Solidity官方文档，对于非数值类型的参数（arrays，bytes,strings），Solidity不会直接存储，
    // 而是会将keccak256哈希存储在主题中，从导致数据信息丢失。
    // 对于某些依赖链上时间的Dapp（跨链、用户注册等）来说，可能会导致时间检索困难，需要解析哈希值


    // 获取事件签名
    function TransferSignature() public pure returns (bytes32) {
        bytes32 sig = keccak256("Transfer(address,address,uint256)");
        return sig;
    }


    // 数据 data
    // 事件中不带indexed的参数会被存储在data部分，可以理解为事件的数据。
    // data部分的变量不能被直接检索，但可存储任意大小的数据。
    // 一般data部分可以用来埌复杂的数据结构,例如数组、字符串等等, 因为这些数据超过了256比特，
    // 即使存储在事件的topics中，也是以哈希的方式存储
    // data部分的变量在存储上消耗的gas相比于topics更少

}