# DegenToken
ETH Intermediate Module 4 - Degen Token ERC20

## Description

An Ethereum blockchain in-game economy is intended to use the DegenToken smart contract, which is an ERC20 token. In addition to having features for determining the cost of in-game goods and allowing token redemption, this contract permits the minting and burning of tokens. By employing the must statement to guarantee appropriate conditions prior to carrying out crucial operations, the contract exemplifies effective error handling methods. Through the implementation of these features, this contract offers valuable insights into creating dependable and safe smart contracts for decentralized transactions within the gaming industry.

## Executing the program

The first requirement to run this program is to use Remix Ethereum IDE (https://remix.ethereum.org/) and create a new files and take note that ".sol" is the correct file format for running a Solidity Program and compile the contract by selecting the appropriate Solidity compiler version (e.g., 0.8.0 or above) and clicking the "Compile DegenToken.sol" button.

To interact with the DegenToken contract and leverage its functionalities, you can use Remix Ethereum IDE. Begin by creating a new ".sol" file and compiling it using a Solidity compiler version 0.8.0 or above. The DegenToken contract, along with the Ownable.sol contract created alongside it, provide the necessary infrastructure for managing ownership and executing restricted functions. After compiling the contract, deploy it by selecting the Ethereum icon on the left sidebar. Once deployed, you can directly interact with its functions within the Remix IDE environment. The mint function facilitates token minting to a specified account, while the burn function allows burning tokens from the sender's account. Using the setItemPrice function, you can establish the price of items in the in-game store by specifying the item ID and the price in tokens. To redeem items from the in-game store, utilize the redeemItem function along with the corresponding item ID. Monitor the contract's behavior in the Remix IDE's "Console" tab, confirming successful function calls through emitted events.

Explore and try different scenarios or functions like not having enough tokens or entering incorrect prices/values to see how the contract responds. If the user encounter any problems, use Remix IDE's debugger and console to understand the essence and functionalities of the codes and try to fix with different methods.

```
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract DegenToken is ERC20, Ownable {
    mapping(uint256 => uint256) public itemPrices;
    mapping(uint256 => uint256) public itemRewards;
    mapping(address => mapping(uint256 => uint256)) public playerItems; // Mapping to store player's items

    event RewardsRedeemed(address indexed player, uint256 amount);
    event ItemPurchased(address indexed player, uint256 indexed itemId);

    constructor(uint256 initialSupply) ERC20("Degen", "DGN") Ownable(msg.sender) {
        // Initialize token supply
        _mint(msg.sender, initialSupply * 10 * decimals());

        // Initialize item prices
        itemPrices[1] = 50; // Item 1: SOCKS - Price: 50 tokens
        itemPrices[2] = 100; // Item 2: SHOES - Price: 100 tokens
        itemPrices[3] = 200; // Item 3: JACKET - Price: 200 tokens
        itemPrices[4] = 300; // Item 4: HOODIE - Price: 300 tokens

        // Initialize item rewards
        itemRewards[1] = 25; // Reward for Item 1: SOCKS
        itemRewards[2] = 50; // Reward for Item 2: SHOES
        itemRewards[3] = 100; // Reward for Item 3: JACKET
        itemRewards[4] = 150; // Reward for Item 4: HOODIE
    }

    function redeemRewards() external {
        uint256 totalRewards;
        for (uint256 i = 1; i <= 4; i++) {
            totalRewards += playerItems[msg.sender][i] * itemRewards[i];
            playerItems[msg.sender][i] = 0; // Reset player's item count
        }

        require(totalRewards > 0, "No rewards to redeem");

        // Transfer rewards to the player
        _mint(msg.sender, totalRewards);

        emit RewardsRedeemed(msg.sender, totalRewards);
    }

    function getPlayerItemAmount(address player) external view returns (uint256) {
    uint256 totalItems;
    for (uint256 i = 1; i <= 4; i++) {
        totalItems += playerItems[player][i];
    }
    return totalItems;
}
    

    function buyItem(uint256 itemId) external {
        require(itemPrices[itemId] > 0, "Item not available for purchase");
        require(balanceOf(msg.sender) >= itemPrices[itemId], "Insufficient balance");

        // Transfer tokens from player to owner (in-game store)
        _transfer(msg.sender, owner(), itemPrices[itemId]);

        // Increment player's item count
        playerItems[msg.sender][itemId]++;

        emit ItemPurchased(msg.sender, itemId);
    }
    function transfer(address recipient, uint256 amount) public virtual override returns (bool) {
    _burn(msg.sender, amount); // Burn tokens from the sender
    _transfer(msg.sender, recipient, amount); // Transfer tokens to the recipient
    return true;
}
}

```
## Additional Information

Student Info and Email address

Alber C Aquino
National Teachers College 
8215420@ntc.edu.ph
