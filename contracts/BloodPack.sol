pragma solidity ^0.5.0;

import "./openzeppelin/ownership/Ownable.sol";
import "./openzeppelin/math/SafeMath.sol";

contract BloodPack {
    using SafeMath for uint256;

    struct History {
        string fromId;
        string fromName;
        string toId;
        string toName;
        string description;
    }

    address owner;
    string public id;
    uint public createdAt;

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
    }

    function transfer(
        string memory fromId, string memory fromName,
        string memory toId, string memory toName,
        string memory description
    ) public onlyOwner {
        History memory history = History(fromId, fromName, toId, toName, description);
        histories.push(history);
    }

    function getHistoriesLength() public view returns (uint) {
        return histories.length;
    }

    function getHistory(uint index) public view returns (
        string memory, string memory,
        string memory, string memory,
        string memory
    ) {
        require(index >= 0 && index < histories.length, "Index out of bounds");
        History memory history = histories[index];
        return (history.fromId, history.fromName, history.toId, history.toName, history.description);
    }
}
