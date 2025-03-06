// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

// 异常 
    // 写智能合约经常会出bug，Solidity中的异常命令有助于debug。

// Error
// error是0.8.4版本新加的内容，方便且高效（省gas）地向用户解释操作失败的原因,
// 同时还可以再抛出异常时携带参数，便于更好的调试。
// 可以在contract外定义异常

// 这里，定义一个TransferNotOwner异常，当用户不是代币的Owner时尝试转账，会抛出该错误。


// error TransferNotOwner(); // 自定义异常
error TransferNotOwner(address sender); // 自定义异常：携带参数



// require
// require命令是Solidity 0.8版本之前抛出异常的常用方法
// 目前主流合约仍在使用，它很好用，唯一的缺点就是gas随着描述异常的字符串长度而增加
// 比error命令要高。
// 使用方法如下:
// require(condition, "error info")，当condition条件不成立时，就会抛出异常


// Assert
// assert命令一般用于程序员写程序debug. 因为它不能解释抛出异常的原因(不能像require那样携带参数)
// 用法:
// assert(condition), 当condition条件不成立时，就会抛出异常


// 三种方法的gas比较
// 通过remix控制台的Debug按钮，可以查到函数调佣所花的gas
// 可以看到：
// - error方法gas最少, 其次是assert，require最多

// Solidity 0.8.0之前的版本，assert抛出的是一个 panic exception，会把剩余的 gas 全部消耗，不会返还。更多细节见官方文档。
// https://docs.soliditylang.org/en/v0.8.17/control-structures.html

contract Errors{

    mapping(uint256 => address) _owners;
    
    // 在使用中，error必须搭配revert命令使用
    // 这里定义一个transferOwner函数，它会检查代币的owner是不是发起人，如果不是就会抛出
    // TransferNotOwner异常；如果是的话，就会转账。
    function transferOwner(uint256 tokenId, address newOwner) public{
        if(_owners[tokenId] != msg.sender) {
            // revert TransferNotOwner(); // 抛出异常
            revert TransferNotOwner(msg.sender);
        }
        _owners[tokenId] = newOwner;
    }


    // 使用require命令重写上面的transferOwner方法
    function transferOwner2(uint tokenId, address newOwner) public  {
        require(_owners[tokenId] != msg.sender, "Transfer not owner");
        _owners[tokenId] = newOwner;
    }


    // 使用assert命令重写transferOwner函数
    function transferOwner3(uint256 tokenId, address newOwner) public {
        assert(_owners[tokenId] != msg.sender);
        _owners[tokenId] = newOwner;
    }



}