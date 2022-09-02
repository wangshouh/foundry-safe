// SPDX-License-Identifier: LGPL-3.0-only
pragma solidity >=0.7.0 <0.9.0;

import "src/GnosisSafe.sol";
import "src/proxies/GnosisSafeProxy.sol";
import "./utils/MockERC20.sol";

import "forge-std/Test.sol";

contract GnosisTest is Test {
    GnosisSafe internal SingletonTest;
    GnosisSafeProxy internal Safe;
    MockERC20 internal Token;

    function setUp() public {
        Token = new MockERC20();
        SingletonTest = new GnosisSafe();
        Safe = new GnosisSafeProxy(address(SingletonTest));
       
        address[] memory ownerAddress = new address[](2);
        uint256 threshold = 2;

        ownerAddress[0] = address(0xd85bF7de2a15FB2Cf44f5beEc271F804A0E6C881);
        ownerAddress[1] = address(0xaB6647aD2A897D814D4c111A36d9fba6ED8ec28A);

        IGnosis(address(Safe)).setup(            
            ownerAddress,
            threshold,
            address(0),
            "",
            address(0),
            address(Token),
            10000,
            payable(address(1))
        );
    }

    function testTransfer() public {
        assertEq(Token.receiver(), address(1));
        assertEq(Token.transferAmount(), 10000);
    }
}

interface IGnosis {
    function setup(
        address[] calldata _owners,
        uint256 _threshold,
        address to,
        bytes calldata data,
        address fallbackHandler,
        address paymentToken,
        uint256 payment,
        address payable paymentReceiver
    ) external;
}