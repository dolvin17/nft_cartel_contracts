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

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/common/ERC2981.sol";

contract CartelPass is ERC721, ERC2981 {
    //////////////////////////////////////////
    // Base Collection Settings
    //////////////////////////////////////////

    uint256 public constant MAX_SUPPLY = 2222;
    uint256 public TOTAL_MINTED = 0;

    event TokenMinted(uint256 indexed tokenId, address indexed owner);

    //////////////////////////////////////////
    // Royalties Configuration
    //////////////////////////////////////////

    constructor(
        address royaltyRecipient
    ) ERC721("Citrus Cartel Pass NFT", "CARTEL") {
        _setDefaultRoyalty(royaltyRecipient, 300); // 3% royalty
    }

    //////////////////////////////////////////
    // Minting Functions
    //////////////////////////////////////////

    // Main minting function
    function mintNFT(address to) public {
        require(totalSupply() < maxSupply(), "MaxSupply");
        require(to != address(0), "InvalidAddress");

        uint256 tokenId = TOTAL_MINTED + 1;
        _safeMint(to, tokenId);
        emit TokenMinted(tokenId, to);
        unchecked {
            TOTAL_MINTED++;
        }
    }

    //////////////////////////////////////////
    // Utility Functions
    //////////////////////////////////////////

    function maxSupply() public pure returns (uint256) {
        return MAX_SUPPLY;
    }

    function totalSupply() public view returns (uint256) {
        return TOTAL_MINTED;
    }

    //////////////////////////////////////////
    // ERC721 Overrides
    //////////////////////////////////////////

    function supportsInterface(
        bytes4 interfaceId
    ) public view override(ERC721, ERC2981) returns (bool) {
        return super.supportsInterface(interfaceId);
    }
}
