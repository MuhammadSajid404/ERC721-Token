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
