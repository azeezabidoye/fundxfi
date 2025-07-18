// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

contract FundXFI {
    address public immutable i_owner;
    uint256 public constant MINIMUM_AMOUNT = 20 * 1e18; // ETH to Wei
    mapping(address => uint256) public addressToAmountFunded;
    mapping(address => bool) private hasFunded;
    address[] private funders;

    constructor() {
        i_owner = msg.sender;
    }

    function fund() external payable {
        require(msg.value > MINIMUM_AMOUNT, "Send some ETH");

        if (!hasFunded[msg.sender]) {
            hasFunded[msg.sender] = true;
            funders.push(msg.sender);
        }

        addressToAmountFunded[msg.sender] += msg.value;
    }

    function withdraw() public onlyOwner {
        for (uint256 i = 0; i < funders.length; i++) {
            address funder = funders[i];
            addressToAmountFunded[funder] = 0;
            hasFunded[funder] = false;
            unchecked {
                ++i;
            } // Save gas by skipping overflow check
        }

        delete funders;
        (bool success, ) = payable(i_owner).call{value: address(this).balance}(
            ""
        );
        require(success, "Withdraw failed");
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Not owner");
        _;
    }

    function getFunders() external view returns (address[] memory) {
        return funders;
    }
}
