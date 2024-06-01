# DegenToken
ETH Intermediate Module 4 - Degen Token ERC20

## Description

An Ethereum blockchain in-game economy is intended to use the DegenToken smart contract, which is an ERC20 token. In addition to having features for determining the cost of in-game goods and allowing token redemption, this contract permits the minting and burning of tokens. By employing the must statement to guarantee appropriate conditions prior to carrying out crucial operations, the contract exemplifies effective error handling methods. Through the implementation of these features, this contract offers valuable insights into creating dependable and safe smart contracts for decentralized transactions within the gaming industry.

## Executing the program

The first requirement to run this program is to use Remix Ethereum IDE (https://remix.ethereum.org/) and create a new files and take note that ".sol" is the correct file format for running a Solidity Program and compile the contract by selecting the appropriate Solidity compiler version (e.g., 0.8.0 or above) and clicking the "Compile DegenToken.sol" button.

To interact with the DegenToken contract and leverage its functionalities, you can use Remix Ethereum IDE. Begin by creating a new ".sol" file and compiling it using a Solidity compiler version 0.8.0 or above. The DegenToken contract, along with the Ownable.sol contract created alongside it, provide the necessary infrastructure for managing ownership and executing restricted functions. After compiling the contract, deploy it by selecting the Ethereum icon on the left sidebar. Once deployed, you can directly interact with its functions within the Remix IDE environment. The mint function facilitates token minting to a specified account, while the burn function allows burning tokens from the sender's account. Using the setItemPrice function, you can establish the price of items in the in-game store by specifying the item ID and the price in tokens. To redeem items from the in-game store, utilize the redeemItem function along with the corresponding item ID. Monitor the contract's behavior in the Remix IDE's "Console" tab, confirming successful function calls through emitted events.

Explore and try different scenarios or functions like not having enough tokens or entering incorrect prices/values to see how the contract responds. If the user encounter any problems, use Remix IDE's debugger and console to understand the essence and functionalities of the codes and try to fix with different methods.

```
// // SPDX-License-Identifier: MIT
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
```
## Additional Information

Student Info and Email address

Alber C Aquino
National Teachers College 
8215420@ntc.edu.ph
