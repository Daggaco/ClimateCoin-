// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "./ClimateCoin.sol";

contract ClimateCoinManager is Ownable {
    ClimateCoin public climateCoin;
    uint256 public feePercentage;
    uint256 private constant MAX_FEE = 100; // Máxima comisión permitida

    struct NFTDetails {
        uint256 credits;
        string projectName;
        string projectURL;
    }

    mapping(uint256 => NFTDetails) public nftDetails;
    mapping(uint256 => address) public nftOwners;

    ERC721 public nftContract;

    event NFTMinted(uint256 indexed tokenId, address indexed developer, uint256 credits);
    event NFTExchanged(uint256 indexed tokenId, address indexed user, uint256 credits);
    event CCBurn(uint256 indexed ccAmount, uint256 indexed tokenId);

    constructor(uint256 initialSupply, address nftAddress) {
        climateCoin = new ClimateCoin(initialSupply);
        nftContract = ERC721(nftAddress);
    }

    function setFeePercentage(uint256 newFeePercentage) external onlyOwner {
        require(newFeePercentage <= MAX_FEE, "Fee exceeds maximum");
        feePercentage = newFeePercentage;
    }

    function mintNFT(
        uint256 credits,
        string memory projectName,
        string memory projectURL,
        address developerAddress
    ) external onlyOwner {
        require(credits > 0, "Credits must be greater than 0");
        uint256 tokenId = nftContract.totalSupply() + 1;
        nftDetails[tokenId] = NFTDetails(credits, projectName, projectURL);
        nftOwners[tokenId] = developerAddress;
        nftContract._safeMint(developerAddress, tokenId);
        emit NFTMinted(tokenId, developerAddress, credits);
    }

    function exchangeNFTForCC(address nftAddress, uint256 nftId) external {
        require(nftContract.ownerOf(nftId) == msg.sender, "You are not the owner");

        uint256 credits = nftDetails[nftId].credits;
        uint256 fee = (credits * feePercentage) / 100;
        uint256 transferAmount = credits - fee;

        nftContract.transferFrom(msg.sender, address(this), nftId);

        climateCoin.transfer(msg.sender, transferAmount);
        climateCoin.transfer(owner(), fee);

        emit NFTExchanged(nftId, msg.sender, credits);
    }

    function burnCCAndNFT(uint256 ccAmount, uint256 tokenId) external {
        require(climateCoin.balanceOf(msg.sender) >= ccAmount, "Insufficient ClimateCoin balance");
        require(nftOwners[tokenId] == address(this), "NFT not owned by contract");

        climateCoin.transferFrom(msg.sender, address(0), ccAmount);
        delete nftDetails[tokenId];
        delete nftOwners[tokenId];

        nftContract._burn(tokenId);
        emit CCBurn(ccAmount, tokenId);
    }
}
