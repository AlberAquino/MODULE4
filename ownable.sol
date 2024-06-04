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
        itemPrices[1] = 50; // Item 1: Potion - Price: 200 tokens
        itemPrices[2] = 100; // Item 2: Super Potion - Price: 400 tokens
        itemPrices[3] = 200; // Item 3: Hyper Potion - Price: 1000 tokens
        itemPrices[4] = 300; // Item 4: Full Restore - Price: 2000 tokens

        // Initialize item rewards
        itemRewards[1] = 25; // Reward for Item 1: Potion
        itemRewards[2] = 50; // Reward for Item 2: Super Potion
        itemRewards[3] = 100; // Reward for Item 3: Hyper Potion
        itemRewards[4] = 150; // Reward for Item 4: Full Restore
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
}
