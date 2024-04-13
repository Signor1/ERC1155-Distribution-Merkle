// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

import "solmate/utils/MerkleProofLib.sol";
import "solmate/tokens/ERC1155.sol";

contract ERC1155Merkle is ERC1155 {
    bytes32 root;

    constructor(bytes32 _root) {
        root = _root;
    }

    mapping(address => bool) public hasClaimed;

    function uri(
        uint256 _id
    ) public view virtual override returns (string memory) {
        return "";
    }

    function claim(
        address _claimer,
        uint256 _amount,
        uint256 _tokenId,
        bytes32[] calldata _proof
    ) external returns (bool success) {
        require(!hasClaimed[_claimer], "already claimed");
        bytes32 leaf = keccak256(abi.encodePacked(_claimer, _amount, _tokenId));
        bool verificationStatus = MerkleProofLib.verify(_proof, root, leaf);
        require(verificationStatus, "not whitelisted");
        hasClaimed[_claimer] = true;
        _mint(_claimer, _amount, _tokenId, "");
        success = true;
    }
}
