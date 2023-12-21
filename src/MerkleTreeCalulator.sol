// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import { RaribleDrop } from "./RaribleDrop.sol";

import { ERC721PartnerRaribleDrop } from "./ERC721PartnerRaribleDrop.sol";

import { AllowListData, MintParams } from "./lib/RaribleDropStructs.sol";

import { Merkle } from "../src-upgradeable/murky/Merkle.sol";

contract MerkleTreeCalculator {

    function createMerkleRootAndProof(
        address[10] memory allowList,
        uint256 proofIndex,
        MintParams memory mintParams
    ) public returns (bytes32 root, bytes32[] memory proof) {
        require(proofIndex < allowList.length);

        // Declare a bytes32 array for the allowlist tuples.
        bytes32[] memory allowListTuples = new bytes32[](allowList.length);

        // Create allowList tuples using allowList addresses and mintParams.
        for (uint256 i = 0; i < allowList.length; i++) {
            allowListTuples[i] = keccak256(
                abi.encode(allowList[i], mintParams)
            );
        }

        // Initialize Merkle.
        Merkle m = new Merkle();

        // Get the merkle root of the allowlist tuples.
        root = m.getRoot(allowListTuples);

        // Get the merkle proof of the tuple at proofIndex.
        proof = m.getProof(allowListTuples, proofIndex);

        // Verify that the merkle root can be obtained from the proof.
        bool verified = m.verifyProof(root, proof, allowListTuples[proofIndex]);
        require(verified);
    }
}