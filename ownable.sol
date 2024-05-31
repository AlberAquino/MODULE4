// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract DegenToken is ERC20, Ownable {
    address public storeAddress; // Address of the in-game store contract

    constructor() ERC20("Degen", "DGN") Ownable(msg.sender) {
        // Initialize token supply
        _mint(msg.sender, 10 * 2**4); // Mint 160 Degen tokens
    }

    function setStoreAddress(address _storeAddress) external onlyOwner {
        storeAddress = _storeAddress;
    }

    function redeemDGN(uint256 amount) external {
        require(storeAddress != address(0), "Store address not set");
        require(balanceOf(msg.sender) >= amount, "Insufficient balance");

        // Transfer tokens to the store for redemption
        _transfer(msg.sender, storeAddress, amount);
    }

       function getBalance(address account) external view returns (uint256) {
        return balanceOf(account);
       }
       function transferDGN(address recipient, uint256 amount) external {
        _transfer(msg.sender, recipient, amount);
    }
       function burnDGN(uint256 amount) external {
        _burn(msg.sender, amount);
    }
    function mint(address account, uint256 amount) external onlyOwner {
        _mint(account, amount);
    }
    
}
