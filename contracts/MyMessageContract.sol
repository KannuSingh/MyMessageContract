// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract MyMessageContract {
    uint256 totalMessages;
    uint256 private seed;

    event NewMessage(address indexed from, uint256 timestamp, string message);

    struct Message {
        address sender;
        string text;
        uint256 timestamp;
    }

    Message[] messages;

    /*
     * This is an address => uint mapping, meaning I can associate an address with a number!
     * In this case, I'll be storing the address with the last time the user waved at us.
     */
    mapping(address => uint256) public lastMessagedAt;

    constructor() payable {
        console.log("Deployed MyMessageContract !");
        /*
         * Set the initial seed
         */
        seed = (block.timestamp + block.difficulty) % 100;
    }

    function message(string memory _message) public {
        /*
         * We need to make sure the current timestamp is at least 15-seconds bigger than the last timestamp we stored
         */
        require(
            lastMessagedAt[msg.sender] + 15 seconds < block.timestamp,
            "Wait 15sec"
        );

        /*
         * Update the current timestamp we have for the user
         */
        lastMessagedAt[msg.sender] = block.timestamp;

        totalMessages += 1;
        console.log("%s had messaged!", msg.sender);

        messages.push(Message(msg.sender, _message, block.timestamp));

        /*
         * Generate a new seed for the next user that sends a wave
         */
        seed = (block.difficulty + block.timestamp + seed) % 100;

        if (seed <= 50) {
            console.log("%s won!", msg.sender);

            uint256 prizeAmount = 0.0001 ether;
            require(
                prizeAmount <= address(this).balance,
                "Trying to withdraw more money than they contract has."
            );
            (bool success, ) = (msg.sender).call{value: prizeAmount}("");
            require(success, "Failed to withdraw money from contract.");
        }

        emit NewMessage(msg.sender, block.timestamp, _message);
    }

    function getAllMessages() public view returns (Message[] memory) {
        return messages;
    }

    function getTotalMessages() public view returns (uint256) {
        return totalMessages;
    }
}