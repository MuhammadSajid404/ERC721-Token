# ERC721-Token
This repository is about ERC721(Non-fungible) Token.

### ERC721 Short Introduction

The ERC-721 standard first gained popularity through the CryptoKitties game, which for a while was the most resource intensive Ethereum network app. Each ERC721 token is unique and rare: each token of this kind has its own attributes, which makes it non-fungible.ERC-721 tokens can only be traded in whole: you cannot transfer or sell half of a digital asset. 
In this standard, a token belongs only to a physical address — an account represented as a user's wallet or another smart contract.

### Address Contract
It is a check on different types of Addresses like zero(0x0) address, contract address, externally owned account addresses etc.
* read comminted text in **Address.sol**.

### ERC165
ERC165 is an interface to check if a contract supports an interface, it's a meta-interface so to say. This is useful if we want to interact with a contract but we don't know if it supports an interface such as ERC20 or ERC721.
As you can guess supportsInterface for ERC165 returns true. Each interface has an interfaceID. For ERC165 it is 0x01ffc9a7. Check the [EIP](https://github.com/ethereum/EIPs/blob/master/EIPS/eip-165.md) for detailed info.

### IERC721
ERC721 interface standard allows for the implementation of a standard API for NFTs within smart contracts. This standard provides basic functionality to track and transfer NFTs. Check the [EIP 721: ERC-721 Non-Fungible Token Standard](https://eips.ethereum.org/EIPS/eip-721).

### SafeMath
Arithmetic operations in Solidity wrap on overflow. This can easily result in bugs, because programmers usually assume that an overflow raises an error, which is the standard behavior in high level programming languages. `SafeMath` restores this intuition by reverting the transaction when an operation overflows.

### myPauseAble
A pausable contract has mechanisms to stop smart contract functionalities such as transfer or approval.
Every asset contract should have this functionality. There are several benefits of a pausable contract. The primary benefit of the pausable token contract is safety. In case of any contract vulnerability which may be needed to update the contract, pausing can stop transfers and other core functionalities which reduces overall risk.

### ERC721
Token standards can be summarized and compared in the following ways:
Ownership — How is token ownership handled?
Creation — How are tokens created?
Transfer & Allowance — How are tokens transferred, and how do we allow other addresses transfer capability?
Burn — How do we burn or destroy a token?

Understanding how these operations work helps to put a complete picture of how a token standard works. [OpenZeppelin ERC721Token.sol](https://github.com/OpenZeppelin/openzeppelin-contracts/tree/master/contracts/token/ERC721) full implementation and amalgamates some additional knowledge of Solidity and other EIPs.
