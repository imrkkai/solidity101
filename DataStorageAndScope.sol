// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

contract DataStorageAndScope {

    uint[] x = [1,2,3];

    function storageFun() public {
        // storage赋值给storage，会创建引用
        // 声明一个storage变量，将x赋值给它。修改mystorage将影响原变量x
        uint[] storage mystorage = x;
        mystorage[0] = 100;
    }


    function memoryFun() public pure returns(uint256 a, uint256){
        // memory 赋值给memory，会创建引用，改变新变量会影响原变量
        uint256[3] memory memory1 = [uint256(1),2,3];
        uint256[3] memory memory2 = memory1;

        memory2[0] = 10;

        return (memory1[0], memory2[0]);
    }
    

    function memoryCopy() public view{
        // 其他情形赋值，都会 创建副本，如：
        // storage赋值给memory会，创建副本，不会影响到原变量
        // 声明一个memory变量mymemory,复制x。修改mymemory不会影响x
        uint[] memory mymemory = x;
        mymemory[0] = 200;
    }


    function calldataFun(uint[] calldata myx) public pure returns(uint[] calldata) {
        // calldata类型变量不允许修改
        // myx[0] = 0; // 尝试修改calldata数据，报错
        return myx;
    }



    // 变量作用域：
    // 1.状态变量 - 数据存储在链上，所有合约内部的函数都可以访问，gas消耗高，状态变量在合约内，函数外声明

    // 2.局部变量 - 仅存在于函数执行过程中，函数退出后，变量无效.局部变量的数据存储在内存中，不上链，gas消耗低

    // 3. 全局变量 - 全局变量是全局范围都有效的变量，是solidity预留的关键字。可以在函数内部不声明直接使用
    

    // 声明状态变量
    
    uint public y;
    string public z;


    function stateFun() external  returns (uint _y, string memory _z){
        
        y = 10;
        z = "hello";

        _y = y;
        _z = z;

        return (_y, _z);
    }


    // 局部变量
    function localFun() public pure returns (uint){

        uint a = 10;
        uint b = 20;
        return a + b;
        
    }

    // 全局变量

    function globalFun() external  view returns(address, uint, bytes memory) {
        address sender = msg.sender;
        uint blockNumber = block.number;
        bytes memory data = msg.data;
        return (sender,blockNumber,data);
    }


    // 以太单位
    // wei = 1
    // kwei = 1e3
    // mwei = 1e6
    // gwei = 1e9 
    // ether = 1e18

    function weiUnit() external pure returns(uint) {
        assert(1 wei == 1e0);
        assert(1 wei == 1);
        return 1 wei;
    }

    function gweiUnit() external pure returns(uint) {
        assert(1 gwei == 1e9);
        assert(1 gwei == 1000000000);
        return 1 gwei;
    }

    function etherUnit() external pure returns(uint) {
        assert (1 ether == 1e18);
        assert(1 ether == 1000000000000000000);
        return 1 ether;
    }



    // 时间单位
    // seconds = 1
    // minutes = 60 * seconds = 3600s
    // hours = 60*minutes =  3600mins=7200sec= 86400s
    // days = 24hours  -> 86400 sec/day(seconds)  = 14400 seconds per day (30days)
    // weeks = 7 dats = 604800

    function secondsUnit() external pure returns(uint) {
        assert(1 seconds == 1);
        return 1 seconds;
    }

    function minutesUnit() external pure returns(uint) {
        assert(1 minutes == 60);
        assert(1 minutes == 60 seconds);
        return 1 minutes;
    }

    function hoursUnit() external pure returns(uint) {
        assert(1 hours == 3600);
        assert(1 hours == 60 minutes);
        return 1 hours;
    }

    function daysUnit() external pure returns(uint) {
        assert(1 days == 86400);
        assert(1 days == 24 hours);
        return 1 days;
    }

    function weeksUnit() external pure returns(uint) {
        assert(1 weeks == 604800);
        assert(1 weeks == 7 days);
        return 1 weeks;
    }



}
