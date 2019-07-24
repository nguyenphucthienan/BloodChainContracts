pragma solidity ^0.5.0;

import "./openzeppelin/lifecycle/Killable.sol";
import "./openzeppelin/math/SafeMath.sol";
import "./BloodPack.sol";

contract BloodChain is Killable {
    using SafeMath for uint256;

    string constant CONTRACT_INFO = "Blood Chain Contract";

    mapping(string => BloodPack) private bloodPacks;

    function getInfo() public pure returns (string memory) {
        return CONTRACT_INFO;
    }

    function sendFund() public payable onlyOwner { }

    function withdraw(uint amount) public payable onlyOwner {
        require (amount <= address(this).balance, "Not enough ETH");
        _owner.transfer(amount);
    }

    function getBloodPack(string memory bloodPackId) public view returns (string memory, uint) {
        BloodPack bloodPack = bloodPacks[bloodPackId];
        return (bloodPack.id(), bloodPack.createdAt());
    }

    function getBloodPackAddress(string memory bloodPackId) public view returns (address) {
        BloodPack bloodPack = bloodPacks[bloodPackId];
        return address(bloodPack);
    }

    function createBloodPack(string memory bloodPackId) public onlyOwner {
        BloodPack bloodPack = new BloodPack(bloodPackId);
        bloodPacks[bloodPackId] = bloodPack;
    }
}
