// SPDX-License-Identifier: MIT
//  ░▒▓██████▓▒░ ░▒▓██████▓▒░░▒▓███████▓▒░▒▓████████▓▒░▒▓████████▓▒░▒▓█▓▒░
// ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░ ░▒▓█▓▒░   ░▒▓█▓▒░      ░▒▓█▓▒░
// ░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░ ░▒▓█▓▒░   ░▒▓█▓▒░      ░▒▓█▓▒░
// ░▒▓█▓▒░      ░▒▓████████▓▒░▒▓███████▓▒░  ░▒▓█▓▒░   ░▒▓██████▓▒░ ░▒▓█▓▒░
// ░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░ ░▒▓█▓▒░   ░▒▓█▓▒░      ░▒▓█▓▒░
// ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░ ░▒▓█▓▒░   ░▒▓█▓▒░      ░▒▓█▓▒░
// ░▒▓██████▓▒░░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░ ░▒▓█▓▒░   ░▒▓████████▓▒░▒▓████████▓▒░
//
//

pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/ReentrancyGuard.sol";

contract CitrusCartel1155 is ERC1155, Ownable(msg.sender), ReentrancyGuard {
    uint public constant PRICE = 0.0002 ether;

    mapping(address => bool) public hasMinted;
    mapping(address => uint8) public whitelistLevel;
    mapping(uint8 => string) public uriByLevel;

    constructor() ERC1155("CITRUSCARTEL") {
        uriByLevel[1] = "https://ipfs.io/ipfs/QmX2v4a7Y6x8Z3g9Qkz5G7J6f8Fq3";
        uriByLevel[2] = "https://ipfs.io/ipfs/QmX2v4a7Y6x8Z3g9Qkz5G7J6f8Fq3";
        uriByLevel[3] = "https://ipfs.io/ipfs/QmX2v4a7Y6x8Z3g9Qkz5G7J6f8Fq3";
        uriByLevel[4] = "https://ipfs.io/ipfs/QmX2v4a7Y6x8Z3g9Qkz5G7J6f8Fq3";
    }

    function uri(uint256 id) public view override returns (string memory) {
        return uriByLevel[uint8(id)];
    }

    function addToWhitelist(address _user, uint8 _level) external onlyOwner {
        require(_level >= 1 && _level <= 4, "Invalid level");
        whitelistLevel[_user] = _level;
    }

    function mint() external payable nonReentrant {
        require(!hasMinted[msg.sender], "Already minted");
        require(whitelistLevel[msg.sender] > 0, "Not whitelisted");
        require(msg.value == PRICE, "Wrong ETH amount");

        uint8 level = whitelistLevel[msg.sender];

        hasMinted[msg.sender] = true;
        _mint(msg.sender, level, 1, "");
    }

    function withdraw() external onlyOwner {
        payable(owner()).transfer(address(this).balance);
    }
}
