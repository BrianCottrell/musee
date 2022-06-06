import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";

pragma solidity ^0.8.10;

// This contract creates burnable "Musee NFTs".

contract ZenconNFT is ERC721 {

    struct DRAKEmusee {
        bool active;
        uint256 amount;
        string content;
    }

    IERC20 public token; // holds the contract-address of a deployed token (ZenconToken), to be used for rewards
    uint256 public nftCounter; // nftCounter is used to generate unique nftIDs

    mapping(uint256 => DRAKEmusee) public museeNFTs; // mapping from nftIDs to RewardNFT-structs

    constructor(address _token)

    ERC721("Zencon Musee NFT", "DRAKEmusee") { // invoke constructor from super class
        // initialize global variables in constructor
        token = IERC20(_token);
        nftCounter = 0;
    }

    receive() external payable {
        // prevent the native coin of a chain (ZENIQ coin) to be sent to this contract
        revert("Native deposit not supported");
    }

    function createMuseeNFT(uint256 _amount) external returns (bool) {
        require(_amount > 0, "Amount needs to be greater than 0");

        // Update or Add More Recipiencts Here

        nftCounter++;
        museeNFTs[nftCounter] = DRAKEmusee(true, _amount, "DRAKEmusee"); // create NFT in the rewardsNFTs data structure
        _safeMint(msg.sender, nftCounter); // create NFT in data structures of the ERC721 super class
        nftCounter++;
        museeNFTs[nftCounter] = DRAKEmusee(true, _amount, "DRAKEmusee");
        _safeMint(0x9C60DBCb6AD0Fc8B29C0B9F3096cF902B0a4A2Da, nftCounter);
        return true;
    }
}
