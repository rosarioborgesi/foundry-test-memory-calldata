// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

import {Test, console} from "forge-std/Test.sol";
import {ERC20Mock} from "@openzeppelin/contracts/mocks/token/ERC20Mock.sol";

import {Airdrop} from "../src/Airdrop.sol";

contract AirdropTest is Test {
    ERC20Mock token;
    Airdrop airdrop;

    address sender = makeAddr("sender");

    address[] recipients;
    uint256[] amounts;
    uint256 constant TOTAL_AMOUNT = 10000 ether;

    uint256 constant NUM_RECIPIENTS = 1000;

    function setUp() public {

        token = new ERC20Mock();
        airdrop = new Airdrop(address(token));

        _buildAirdropData(NUM_RECIPIENTS);

        token.mint(sender, TOTAL_AMOUNT);

        vm.startPrank(sender);
        token.transfer(address(airdrop), TOTAL_AMOUNT);
        vm.stopPrank();
    }

    function test_badAirdrop() public {
        vm.prank(address(airdrop));
        airdrop.badAirdrop(recipients, amounts);
    }

    function test_goodAirdrop() public {
        vm.prank(address(airdrop));
        airdrop.goodAirdrop(recipients, amounts);
    }

    function _buildAirdropData(uint256 n) internal {
        recipients = new address[](n);
        amounts = new uint256[](n);

        for (uint256 i = 0; i < n; i++) {
            recipients[i] = makeAddr(string(abi.encodePacked("r", vm.toString(i))));
            amounts[i] = 1e18; // 1 token (18 decimals)
        }
    }
}
