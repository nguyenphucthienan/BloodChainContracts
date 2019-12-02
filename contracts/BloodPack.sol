pragma solidity ^0.5.0;

import "./openzeppelin/ownership/Ownable.sol";
import "./openzeppelin/math/SafeMath.sol";

contract BloodPack {
    using SafeMath for uint256;

    enum HistoryType {
        TransferBloodPack,
        TransferBloodProduct,
        DisposeBloodPack,
        DisposeBloodProduct,
        ConsumeBloodProduct
    }

    struct History {
        HistoryType historyType;
        string operatedBy;
        string id;
        string from;
        string to;
        string description;
        uint transferedAt;
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
        HistoryType historyType,
        string memory operatedBy,
        string memory _id,
        string memory from, string memory to,
        string memory description
    ) public onlyOwner {
        History memory history = History(historyType, operatedBy, _id, from, to, description, now.mul(1000));
        histories.push(history);
    }

    function getHistoriesLength() public view returns (uint) {
        return histories.length;
    }

    function getHistory(uint index) public view returns (
        HistoryType, string memory, string memory,
        string memory, string memory, string memory, uint
    ) {
        require(index >= 0 && index < histories.length, "Index out of bounds");
        History memory history = histories[index];
        return (
            history.historyType, history.operatedBy,
            history.id, history.from, history.to,
            history.description, history.transferedAt
        );
    }
}
