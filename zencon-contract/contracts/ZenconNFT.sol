//SPDX-License-Identifier: UNLICENSED
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

pragma solidity ^0.8.10;

// This contract creates "reward-NFTs" that hold a specified amount of token.
// Those reward-NFTs can be claimed to payout tokens to NFT-owners.
// You can think of reward-NFTs like a voucher or gift card.
contract ZenconNFT is ERC721 {

    struct Musee {
        // this struct can be expanded for application-specific NFT functionalities
        bool active;
        uint256 amount;
        uint256 nftNumber;
    }

    IERC20 public token; // holds the contract-address of a deployed token (ZenconToken), to be used for rewards
    uint256 public nftCounter; // nftCounter is used to generate unique nftIDs

    mapping(uint256 => Musee) public museeNFTs; // mapping from nftIDs to RewardNFT-structs

    event CreateReward(address indexed sender, uint256 amount, uint256 nftId);
    event ClaimReward(address indexed sender, uint256 amount, uint256 claimTime, uint256 nftId);

    constructor(address _token)
    ERC721("Zencon Musee NFT", "Musee") { // invoke constructor from super class
        // initialize global variables in constructor
        token = IERC20(_token);
        nftCounter = 0;
    }

    receive() external payable {
        // prevent the native coin of a chain (ZENIQ coin) to be sent to this contract
        revert("Native deposit not supported");
    }

    function createMuseeNFT(uint256 _amount, uint256 _nft_number) external returns (bool) {
        require(_amount > 0, "Amount needs to be greater than 0");

        // Check if this contract is allowed to transfer ERC20-tokens from your wallet.
        // An allowance can be granted by calling the approve-function of the ERC20-token.
        // For example, a frontend can connect to a wallet and call the approve-function right before calling this function.
        // require(token.allowance(msg.sender, address(this)) >= _amount, "Set token allowance first");

        // // Transfers tokens from your wallet to this contract
        // bool successTx = token.transferFrom(msg.sender, address(this), _amount);
        // require(successTx, "Transfer failed");

        nftCounter++;
        museeNFTs[nftCounter] = Musee(true, _amount, _nft_number); // create NFT in the rewardsNFTs data structure
        _safeMint(msg.sender, nftCounter); // create NFT in data structures of the ERC721 super class

        emit CreateReward(msg.sender, _amount, nftCounter);
        return true;
    }

    // function claimMuseeNFT(uint256 nftId) public returns (bool) {
    //     require(ownerOf(nftId) == msg.sender, "cannot claim an NFT that you do not own");

    //     Musee storage nft = museeNFTs[nftId];
    //     require(nft.active, "cannot claim the same NFT twice");
    //     nft.active = false; // prevent the same NFT from being claimed multiple times

    //     bool success = token.transfer(msg.sender, nft.amount);
    //     require(success == true, "Transfer failed");

    //     emit ClaimReward(msg.sender, nft.amount, uint32(block.timestamp), nftId);
    //     return true;
    // }
}
