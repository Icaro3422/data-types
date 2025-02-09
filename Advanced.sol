// SPDX-License-Identifier: MIT
pragma solidity ^0.8.26;

contract Ownable {
    address owner;

    modifier onlyOwner() {
        require(msg.sender == owner, "must be owner");
        _;
    }

    constructor() {
        owner = msg.sender;
    }
}

contract SecretVault {
    string secret;

    constructor(string memory _secret) {
        secret = _secret;
    }

    function getSecret() public view returns (string memory) {
        return secret;
    }
}

contract Advanced is Ownable {
    address secretVault;

    constructor(string memory _secret) {
        super;
        SecretVault _secretVault = new SecretVault(_secret);
        secretVault = address(_secretVault);
    }

    function getSecret() public view onlyOwner returns (string memory) {
        return SecretVault(secretVault).getSecret();
    }
}

