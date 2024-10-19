// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MultiDonation {
    mapping(address => uint256) public donations;

    event DonationSent(address indexed donor, address[] recipients, uint256 totalAmount);

    // Function to batch send donations to multiple addresses
    function batchDonate(address[] calldata recipients) external payable {
        require(msg.value > 0, "No Ether sent");
        uint256 totalRecipients = recipients.length;
        require(totalRecipients > 0, "No recipients provided");
        
        uint256 amountPerRecipient = msg.value / totalRecipients;
        require(amountPerRecipient > 0, "Donation amount too small for division");

        for (uint256 i = 0; i < totalRecipients; i++) {
            payable(recipients[i]).transfer(amountPerRecipient);
        }
        
        donations[msg.sender] += msg.value;
        emit DonationSent(msg.sender, recipients, msg.value);
    }

    // Get the total amount donated by a user
    function getTotalDonations(address donor) external view returns (uint256) {
        return donations[donor];
    }
}c
