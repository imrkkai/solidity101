// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;


/**
{internal|external|public|private}：函数可见性说明符，共有4种。
public：内部和外部均可见。
private：只能从本合约内部访问，继承的合约也不能使用。
external：只能从合约外部访问（但内部可以通过 this.f() 来调用，f是函数名）。
internal: 只能从合约内部访问，继承的合约可以用。
**/

contract FunctionTypes {
    uint256 public number = 5;

    function add() external  {
        number += 1;
    }

    function addPure(uint256 _number) external pure 
    returns(uint256 newNumber) {
        newNumber = _number + 1;
    }


    function addView() external 
    view returns(uint256 new_number) {
        new_number = number+1;
    }


    function minus() internal {
        number = number - 1;
    }


    // 合约函数可以调佣内部函数
    function minusCall() external {
        minus();
    }


    function minusPayable() external payable returns(uint256 balance){
        minus();
        balance = address(this).balance;
    }



}