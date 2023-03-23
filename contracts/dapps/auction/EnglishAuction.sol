// SPDX-License-Identifier: Unlicense
pragma solidity 0.8.7;

interface IERC721 {
    function transferFrom(
        address from,
        address to,
        uint256 tokenId
    ) external;
}

contract EnglishAuction {
    address payable public immutable seller; // Seller Address
    IERC721 public immutable nft; // NFT Address
    uint256 public immutable nftId; // NFT TokenID
    uint32 public endAt; // Auction End Time (Why? uint32 cause it will cover 100 years from now)
    bool public isAuctionStarted;
    bool public isAuctionEnded;

    address public highestBider; // Highest Bidder Address
    uint256 public highestBid; // Highest Bid Amount

    mapping(address => uint256) public bids; // Balance of Bids

    event AuctionStarted(uint256 time);
    event Bid(address indexed bider, uint256 indexed amount);
    event Withdraw(address indexed account, uint256 balance);
    event AuctionEnd(uint256 time);

    constructor(
        IERC721 _nft,
        uint256 _tokenId,
        uint256 _startPrice
    ) {
        seller = payable(msg.sender);
        nft = _nft;
        nftId = _tokenId;
        highestBid = _startPrice;
    }

    function startAuction() external {
        require(msg.sender == seller, "Only Seller Can Start Auciton");
        require(!isAuctionStarted, "Auciton Already Started");
        isAuctionStarted = true;
        endAt = uint32(block.timestamp + 60);
        nft.transferFrom(seller, address(this), nftId);
        emit AuctionStarted(block.timestamp);
    }

    function bid() external payable {
        require(isAuctionStarted, "Auction Not Started Yet!");
        require(block.timestamp < endAt, "Auction Expired!");
        require(msg.value > highestBid, "Less then highestBid");

        if (highestBider != address(0)) {
            bids[highestBider] += highestBid;
        }
        highestBider = msg.sender;
        highestBid = msg.value;

        emit Bid(highestBider, highestBid);
    }

    function withdraw() external {
        uint256 bal = bids[msg.sender];
        bids[msg.sender] = 0;
        payable(msg.sender).transfer(bal);
        emit Withdraw(msg.sender, bal);
    }

    function endAuction() external {
        require(isAuctionStarted, "Auction Not Started");
        require(!isAuctionEnded, "Auction Already Ended");
        require(block.timestamp >= endAt, "Auction is Live");

        isAuctionEnded = true;

        if (highestBider != address(0)) {
            nft.transferFrom(address(this), highestBider, nftId);
            seller.transfer(highestBid);
        } else {
            nft.transferFrom(address(this), seller, nftId);
        }

        emit AuctionEnd(block.timestamp);
    }
}

// Bid 1 -> 10 (1) // 0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2 
// Bid 2 -> 15 (2) // 0x4B20993Bc481177ec7E8f571ceCaE8A9e22C02db
// Bid 3 -> 20 (1) // 0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2 3137
// Bid 4 -> 25 (1) // 0x78731D3Ca6b7E34aC0F824c42a7cC18A495cabaB
