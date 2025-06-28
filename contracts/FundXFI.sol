// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

contract FundXFI {
    address public immutable i_owner;
    uint256 public minimumAmount = 20 * 1e18; // ETH to Wei
    mapping(address => uint256) public addressToAmountFunded;
    mapping(address => bool) private hasFunded;
    address[] private funders;

    constructor() {
        owner = msg.sender;
    }

    function fund() external payable {
        require(msg.value > minimumAmount, "Send some ETH");

        if (!hasFunded[msg.sender]) {
            hasFunded[msg.sender] = true;
            funders.push(msg.sender);
        }

        addressToAmountFunded[msg.sender] += msg.value;
    }

    function withdraw() public onlyOwner {
        uint256 len = funders.length;

        for (uint256 i = 0; i < len; i++) {
            address funder = funders[i];
            addressToAmountFunded[funder] = 0;
            hasFunded[funder] = false;
            unchecked {
                ++i;
            } // Save gas by skipping overflow check
        }

        funders = new address[](0);
        payable(owner).transfer(address(this).balance);
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Not owner");
        _;
    }

    function getFunders() external view returns (address[] memory) {
        return funders;
    }
}
