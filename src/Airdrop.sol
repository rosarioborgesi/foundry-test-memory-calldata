// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

import {ERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract  Airdrop {
    ERC20 public immutable token;

    constructor(address _token) {
        token = ERC20(_token);
    }
    
    function badAirdrop(address[] memory recipients, uint256[] memory amounts) external {
        for (uint256 i = 0; i < recipients.length; i++) {
            token.transfer(recipients[i], amounts[i]);
        }
    }
    
    function goodAirdrop(address[] calldata recipients, uint256[] calldata amounts) external {
        for (uint256 i = 0; i < recipients.length; i++) {
            token.transfer(recipients[i], amounts[i]);
        }
    }

}
