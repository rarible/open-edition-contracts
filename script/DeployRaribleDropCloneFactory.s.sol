// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import { Script, console2 } from "forge-std/Script.sol";
import {
    ERC721RaribleDropCloneFactory
} from "../src/clones/ERC721RaribleDropCloneFactory.sol";
import {ScriptBase, console2} from "./ScriptBase.sol";

contract DeployRaribleDropCloneFactory is ScriptBase {
    function run() public {
        setUp();
        bytes memory creationCode = type(ERC721RaribleDropCloneFactory).creationCode;
        console2.logBytes32(keccak256(creationCode));
        bytes32 salt = bytes32(0x0000000000000000000000000000000000000000d40ba0de8b5adb1cc4070009);
        // bytes32 salt = bytes32(0);

        vm.broadcast(deployer);
        address operatorFilterRegistry = IMMUTABLE_CREATE2_FACTORY.safeCreate2(salt, creationCode);
        console2.logAddress(operatorFilterRegistry);
    }
}
