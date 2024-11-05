// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

contract Bank {
    // custom errors
    error OwnableUnauthorizedAccount(address account);
    error OwnableInvalidOwner(address owner);

    // events
    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    // it's in slot 0
    address private _owner;

    constructor() {
        assembly {
            // write owner to slot 0
            sstore(0, caller())
        }
        emit OwnershipTransferred(address(0), msg.sender);
    }

    modifier onlyOwner() {
        if (owner() != msg.sender) {
            revert OwnableUnauthorizedAccount(msg.sender);
        }
        _;
    }

    function transferOwnership(address newOwner) public onlyOwner {
        if (newOwner == address(0)) {
            revert OwnableInvalidOwner(newOwner);
        }
        _transferOwnership(newOwner);
    }

    function _transferOwnership(address newOwner) internal {
        address oldOwner = owner();
        assembly {
            // store new owner to slot 0
            sstore(0, newOwner)
        }
        emit OwnershipTransferred(oldOwner, newOwner);
    }

    function owner() public view returns (address) {
        address owner_;
        assembly {
            // read owner from slot 0
            owner_ := sload(0)
        }
        return owner_;
    }

    // Receive ETH
    receive() external payable { }
}
