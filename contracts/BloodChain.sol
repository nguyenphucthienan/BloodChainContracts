pragma solidity ^0.5.0;

import "./openzeppelin/lifecycle/Killable.sol";
import "./openzeppelin/math/SafeMath.sol";
import "./UserInfo.sol";
import "./BloodPack.sol";

contract BloodChain is Killable {
    using SafeMath for uint256;

    string constant CONTRACT_INFO = "Blood Chain Contract";

    mapping(string => UserInfo) private userInfos;
    mapping(string => BloodPack) private bloodPacks;

    function getInfo() public pure returns (string memory) {
        return CONTRACT_INFO;
    }

    function fund() public payable { }

    function transfer(address payable toAddress, uint amount) public payable onlyOwner {
        require (amount <= address(this).balance, "Not enough ETH");
        toAddress.transfer(amount);
    }

    function getUserInfo(string memory userId) public view returns (string memory, uint, uint) {
        UserInfo userInfo = userInfos[userId];
        return (userInfo.id(), userInfo.createdAt(), userInfo.point());
    }

    function getUserInfoAddress(string memory userId) public view returns (address) {
        UserInfo userInfo = userInfos[userId];
        return address(userInfo);
    }

    function createUserInfo(string memory userId) public onlyOwner {
        UserInfo userInfo = new UserInfo(userId);
        userInfos[userId] = userInfo;
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
