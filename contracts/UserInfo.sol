pragma solidity ^0.5.0;

import "./openzeppelin/ownership/Ownable.sol";
import "./openzeppelin/math/SafeMath.sol";

contract UserInfo {
    using SafeMath for uint256;

    struct History {
        uint amount;
        string description;
        uint updatedAt;
    }

    address payable owner;
    string public id;
    uint public createdAt;
    uint public point;

    History[] histories;

    modifier onlyOwner() {
        require(isOwner(), "Caller is not the owner");
        _;
    }

    function isOwner() public view returns (bool) {
        return msg.sender == owner;
    }

    constructor (string memory _id) public {
        owner = tx.origin;
        id = _id;
        createdAt = now.mul(1000);
        point = 0;
    }

    function addPoint(uint amount, string memory description) public onlyOwner {
        point = point.add(amount);
        History memory history = History(amount, description, now.mul(1000));
        histories.push(history);
    }

    function getHistoriesLength() public view returns (uint) {
        return histories.length;
    }

    function getHistory(uint index) public view returns (uint, string memory, uint) {
        require(index >= 0 && index < histories.length, "Index out of bounds");
        History memory history = histories[index];
        return (history.amount, history.description, history.updatedAt);
    }
}
