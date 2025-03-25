// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/security/Pausable.sol";

contract AdvancedToken is ERC20, Ownable, Pausable {
    uint256 public transactionFee = 5; // Fee in basis points (0.5%)
    address public feeRecipient;
    mapping(address => bool) private blacklisted;

    event Blacklisted(address indexed account, bool value);
    event TransactionFeeUpdated(uint256 newFee);
    event FeeRecipientUpdated(address newRecipient);

    constructor(uint256 initialSupply, address _feeRecipient) ERC20("AdvancedToken", "ATK") Ownable(msg.sender) {
        _mint(msg.sender, initialSupply * 10**decimals());
        feeRecipient = _feeRecipient;
    }

    // Transfer function with transaction fee deduction
    function _transfer(address sender, address recipient, uint256 amount) internal override whenNotPaused {
        require(!blacklisted[sender], "Sender is blacklisted");
        require(!blacklisted[recipient], "Recipient is blacklisted");

        uint256 feeAmount = (amount * transactionFee) / 1000;
        uint256 netAmount = amount - feeAmount;

        super._transfer(sender, feeRecipient, feeAmount); // Send fee
        super._transfer(sender, recipient, netAmount);   // Send remaining tokens
    }

    // Function to update transaction fee
    function setTransactionFee(uint256 newFee) external onlyOwner {
        require(newFee <= 50, "Fee too high"); // Max 5%
        transactionFee = newFee;
        emit TransactionFeeUpdated(newFee);
    }

    // Function to update fee recipient
    function setFeeRecipient(address newRecipient) external onlyOwner {
        require(newRecipient != address(0), "Invalid address");
        feeRecipient = newRecipient;
        emit FeeRecipientUpdated(newRecipient);
    }

    // Function to pause/unpause transfers
    function togglePause() external onlyOwner {
        paused() ? _unpause() : _pause();
    }

    // Mint new tokens (OnlyOwner)
    function mint(address to, uint256 amount) external onlyOwner {
        _mint(to, amount);
    }

    // Burn tokens (OnlyOwner)
    function burn(uint256 amount) external onlyOwner {
        _burn(msg.sender, amount);
    }

    // Blacklist an address
    function setBlacklist(address account, bool value) external onlyOwner {
        blacklisted[account] = value;
        emit Blacklisted(account, value);
    }

    // Check if an address is blacklisted
    function isBlacklisted(address account) external view returns (bool) {
        return blacklisted[account];
    }
}
