// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;


contract MockERC20 {
    uint256 public transferAmount;
    address public receiver;
    
    function transfer(address refundReceiver, uint256 amount) public {
        transferAmount = amount;
        receiver = refundReceiver;
    }

    receive() external payable {}

}