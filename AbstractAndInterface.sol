// SPDX-License-Identifier: MIT
pragma solidity ^0.8.21;

    // 抽象合约
    // 抽象合约 - 如果一个合约中有至少一个未实现的函数，既某个函数缺少主体的内容，则必须将合约标记为abstract，否则编译报错.
    // 未实现的函数需要加virtual，以便子合约可以重写
abstract contract InsertSort {
    function sort(uint[] memory a) public pure virtual returns (uint[] memory);
}

// 接口
// 接口类似于抽象合约，但它不能实现任何功能
// 接口规则如下:
// - 不能包含状态变量
// - 不能包含构造函数
// - 不能继承除接口外的其他合约
// - 所有函数都必须是external且不能有函数体
// - 实现接口的非抽象合约必须实现接口定义的所有功能

// 接口不实现任何功能，但十分重要。接口是智能合约的框架，定义了合约的功能以及如何触发它们。
// 如果智能合约实现了某种接口，比如ERC20，ERC721。其他Dapps和智能合约就知道如何与它进行交互。
// 因为接口提供两个重要的信息:
// 1. 合约里每个函数的bytes4选择器，一起函数签名 函数名(参数类型列表)
// 2. 接口id（更多信息见EIP165）

// 接口与合约abi等级，可以相互转换
// 编译接口可以得到合约的abi，利用abi-to-sol工具也可以将abi json文件转换为接口sol文件。

// 这里以ERC721接口合约IERC721为例，它定义了3个event和9个function，所有的ERC721标准的NFT都实现了这些函数.
// 可以看的，接口和常规合约的区别在于每个函数都以;代替了函数体{}结尾。

interface IERC721 /*is IERC165*/ {
    event Transfer(address indexed from, address indexed to, uint256 indexed tokenId);
    event Approval(address indexed owner, address indexed approved, uint256 indexed tokenId);
    event ApprovalForAll(address indexed owner, address indexed operator, bool approved);
    
    function balanceOf(address owner) external view returns (uint256 balance);

    function ownerOf(uint256 tokenId) external view returns (address owner);

    function safeTransferFrom(address from, address to, uint256 tokenId) external;

    function transferFrom(address from, address to, uint256 tokenId) external;

    function approve(address to, uint256 tokenId) external;

    function getApproved(uint256 tokenId) external view returns (address operator);

    function setApprovalForAll(address operator, bool _approved) external;

    function isApprovedForAll(address owner, address operator) external view returns (bool);

    function safeTransferFrom( address from, address to, uint256 tokenId, bytes calldata data) external;
}


// IERC721事件
// IERC721包含3个事件，其中Transfer和Approval事件在ERC20中也有。
// - Transfer事件：在转账时被释放，记录代币的发出地址from，接收地址to和tokenId。
// - Approval事件：在授权时被释放，记录授权地址owner，被授权地址approved和tokenId。
// - ApprovalForAll事件：在批量授权时被释放，记录批量授权的发出地址owner，被授权地址operator和授权与否的approved。


// IERC721函数
// - balanceOf：返回某地址的NFT持有量balance。
// - ownerOf：返回某tokenId的所有者owner。
// - transferFrom：普通转账，参数为转出地址from，接收地址to和tokenId。
// - safeTransferFrom：安全转账（如果接收方是合约地址，会要求实现ERC721Receiver接口）。参数为转出地址from，接收地址to和tokenId。
// - approve：授权另一个地址使用你的NFT。参数为被授权地址approve和tokenId。
// - getApproved：查询tokenId被批准给了哪个地址。
// - setApprovalForAll：将自己持有的该系列NFT批量授权给某个地址operator。
// - isApprovedForAll：查询某地址的NFT是否批量授权给了另一个operator地址。
// - safeTransferFrom：安全转账的重载函数，参数里面包含了data。


// 什么时候使用接口
// 如果知道一个合约实现了IERC721接口，就可以在不知道具体代码实现，与之交互

// 无聊猿BAYC属于ERC721代币，实现了IERC721接口的功能，我们就不需要知道它的源代码，只需要知道它的合约地址
// 用IERC721接口就可以与它进行交互。
// 比如,使用balanceOf()来查询某个地址的BAYC余额，用safeTransferFrom来转账BAYC。

contract InteractBAYC {
    // 利用BAYC地址创建接合约变量(ETH主网)
    IERC721 BAYC = IERC721(0xBC4CA0EdA7647A8aB7C2061c2E118A18a936f13D);

    //通过接口调用BAYC的balanceOf()查询持仓量
    function balanceOf(address owner) external  view returns (uint256 balance) {
        return BAYC.balanceOf(owner);
    }

    //通过接口调用BAYC的safeTransferFrom()安全转账
    function safeTransferFromBAYC(address from, address to, uint256 tokenId) external {

        BAYC.safeTransferFrom(from, to, tokenId);
    } 

}


abstract contract Base {
    string public name = "Base";
    function getAlias() public pure virtual returns(string memory);
}

contract BaseImpl is Base {
    function getAlias() public pure override returns(string memory) {
        return "BaseImpl";
    }
}


interface IBase {
    function getName() external pure returns (string memory);
}

contract MyBaseImpl is IBase {
    function getName() external pure override returns(string memory) {
        return 'MyBaseImpl';
    }
}