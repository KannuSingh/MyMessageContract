// SPDX-License-Identifier: UNLICENSED

pragma solidity ^0.8.0;

import "hardhat/console.sol";

contract WavePortal {
    uint256 totalUsers;
    mapping(address => uint256) usersWaveCount;
    
    constructor() {
        console.log("True Fantasy Sport Contract deployed.");
    }

    function waveAndRegister() public {
        if(usersWaveCount[msg.sender] == 0){
            totalUsers += 1;
            console.log("%s has registered!", msg.sender);
        }
        usersWaveCount[msg.sender] = usersWaveCount[msg.sender] + 1;
        console.log("%s has waved!", msg.sender);
    }

    function getTotalUsers() public view returns (uint256) {
        console.log("We have %d total users!", totalUsers);
        return totalUsers;
    }

   
}