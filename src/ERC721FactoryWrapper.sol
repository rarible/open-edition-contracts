// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;
import { IRaribleDrop } from "./interfaces/IRaribleDrop.sol";
import { ERC721RaribleDropCloneFactory } from "./clones/ERC721RaribleDropCloneFactory.sol";
import { ERC721RaribleDropCloneable } from "./clones/ERC721RaribleDropCloneable.sol";
import "./ERC721RaribleDrop.sol";

contract ERC721FactoryWrapper {

    constructor() {

    }

    event ERC721Deployed(address collection);

    struct ERC721Settings {
        address erc721RaribleDropCloneFactory;
        string name;
        string symbol;
        bytes32 salt;
    }

    function deployCollection(ERC721Settings memory _erc721Settings, IRaribleDrop _raribleDrop) external returns (address erc721RaribleDrop) {
        erc721RaribleDrop = ERC721RaribleDropCloneFactory(_erc721Settings.erc721RaribleDropCloneFactory).createCloneForOwner(_erc721Settings.name, _erc721Settings.symbol, _erc721Settings.salt, msg.sender);
        emit ERC721Deployed(erc721RaribleDrop);
        
    }
}