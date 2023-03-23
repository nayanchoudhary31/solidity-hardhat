// SPDX-License-Identifier: Unlicense
pragma solidity 0.8.7;

interface IERC721 {
    function transferFrom(
        address from,
        address to,
        uint256 tokenId
    ) external;
}

contract DutchAuction {
    uint256 private constant DURATION = 7 days; // Acution Duration
    IERC721 private immutable nft; // NFT Address
    uint256 public immutable nftId; // Token Id
    address payable private immutable seller; // Seller Address
    uint256 public immutable startPrice; // Starting Price for the NFT
    uint256 public immutable startAt; // Auction Start At
    uint256 public immutable endAt; // Auction End At
    uint256 public immutable discountRate; // Rate at which price will decrease

    constructor(
        IERC721 _nft,
        uint256 _tokenId,
        uint256 _startPrice,
        uint256 _discountRate
    ) {
        require(
            _startPrice >= _discountRate * DURATION,
            "start price < discountRate"
        );
        nft = _nft;
        nftId = _tokenId;
        seller = payable(msg.sender);
        startPrice = _startPrice;
        startAt = block.timestamp;
        endAt = block.timestamp + DURATION;
        discountRate = _discountRate;
    }

    function getPrice() public view returns (uint256) {
        uint256 timeElapsed = block.timestamp - startAt; //
        uint256 discount = discountRate * timeElapsed;
        return startPrice - discount;
    }

    function buy() external payable {
        require(block.timestamp < endAt, "Auction Expired"); // Auction Expired Check
        uint256 price = getPrice(); // Get The Current NFT Price
        require(msg.value >= price, "ETH < Price"); // Price Check
        nft.transferFrom(seller, msg.sender, nftId); // Transfer the NFT
        uint256 refund = msg.value - price; // If User Send More ETH than Price

        if (refund > 0) {
            payable(msg.sender).transfer(refund); // We Refund The Extra ETH
        }

        selfdestruct(seller); // We Delete the contract and Send ETH to Seller
    }
}
