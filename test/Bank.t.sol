// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

import { Test, console2 } from "forge-std/Test.sol";
import { Bank } from "../src/Bank.sol";

contract BankTest is Test {
    Bank public bank;
    address public owner;
    address public alice;
    address public bob;

    // setup test environment
    function setUp() public {
        owner = makeAddr("owner");
        alice = makeAddr("alice");
        bob = makeAddr("bob");

        vm.prank(owner);
        bank = new Bank();
    }

    // test initial state
    function test_InitialState() public {
        assertEq(bank.owner(), owner);
    }

    // test transfer ownership
    function test_TransferOwnership() public {
        vm.prank(owner);
        bank.transferOwnership(alice);
        assertEq(bank.owner(), alice);
    }

    // test transfer ownership not owner
    function testFail_TransferOwnershipNotOwner() public {
        vm.prank(alice);
        bank.transferOwnership(bob);
    }

    // test transfer ownership to zero address
    function testFail_TransferOwnershipToZeroAddress() public {
        vm.prank(owner);
        bank.transferOwnership(address(0));
    }

    // test transfer ownership event
    function test_TransferOwnershipEvent() public {
        vm.prank(owner);
        vm.expectEmit(true, true, false, false);
        emit Bank.OwnershipTransferred(owner, alice);
        bank.transferOwnership(alice);
    }

    // test receive ether
    function test_ReceiveEther() public {
        uint256 amount = 1 ether;
        hoax(alice, amount);

        // send ether to contract
        (bool success,) = address(bank).call{ value: amount }("");
        assertTrue(success);

        // verify contract balance
        assertEq(address(bank).balance, amount);
    }

    // test onlyOwner modifier
    function test_OnlyOwnerModifier() public {
        vm.expectRevert(abi.encodeWithSelector(Bank.OwnableUnauthorizedAccount.selector, alice));
        vm.prank(alice);
        bank.transferOwnership(bob);
    }

    // fuzzing: transfer ownership
    function testFuzz_TransferOwnership(address newOwner) public {
        vm.assume(newOwner != address(0));

        vm.prank(owner);
        bank.transferOwnership(newOwner);
        assertEq(bank.owner(), newOwner);
    }
}
