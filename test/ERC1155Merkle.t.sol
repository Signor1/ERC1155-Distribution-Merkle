// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {Test, console2, stdJson} from "forge-std/Test.sol";

import {ERC1155Merkle} from "../src/ERC1155Merkle.sol";

contract ERC1155MerkleTest is Test {
    using stdJson for string;

    ERC1155Merkle public merkle;

    struct Result {
        bytes32 leaf;
        bytes32[] proof;
    }

    struct User {
        address user;
        uint256 amount;
        uint256 tokenId;
    }

    Result public result;
    User public user;
    bytes32 root =
        0x71dab4df0f774529af4710b925787ca372e6cdd7d49787a07aaf764b01c52f16;

    address user1 = 0x2bfAd3F6722500c199b87451A11BEeaeEEad2922;

    function setUp() public {
        merkle = new ERC1155Merkle(root);
        string memory _root = vm.projectRoot();
        string memory path = string.concat(_root, "/merkle_tree.json");

        string memory json = vm.readFile(path);
        string memory data = string.concat(_root, "/address_data.json");

        string memory dataJson = vm.readFile(data);

        bytes memory encodedResult = json.parseRaw(
            string.concat(".", vm.toString(user1))
        );
        user.user = vm.parseJsonAddress(
            dataJson,
            string.concat(".", vm.toString(user1), ".address")
        );
        user.amount = vm.parseJsonUint(
            dataJson,
            string.concat(".", vm.toString(user1), ".amount")
        );
        user.tokenId = vm.parseJsonUint(
            dataJson,
            string.concat(".", vm.toString(user1), ".token_id")
        );
        result = abi.decode(encodedResult, (Result));
        console2.logBytes32(result.leaf);
    }

    function testForSuccessfulClaimed() public {
        bool success = merkle.claim(
            user.user,
            user.amount,
            user.tokenId,
            result.proof
        );
        assertTrue(success);
    }

    function testWhetherAlreadyClaimed() public {
        merkle.claim(user.user, user.amount, user.tokenId, result.proof);
        vm.expectRevert("already claimed");
        merkle.claim(user.user, user.amount, user.tokenId, result.proof);
    }

    function testIncorrectProof() public {
        bytes32[] memory fakeProofleaveitleaveit;

        vm.expectRevert("not whitelisted");
        merkle.claim(
            user.user,
            user.amount,
            user.tokenId,
            fakeProofleaveitleaveit
        );
    }
}
