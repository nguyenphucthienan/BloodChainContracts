pragma solidity ^0.5.0;

import "./openzeppelin/ownership/Ownable.sol";
import "./openzeppelin/math/SafeMath.sol";

contract BloodPack is Ownable {
    using SafeMath for uint256;

    string public id;
    uint public createdAt;

    constructor (string memory _id) public {
        _owner = msg.sender;
        id = _id;
        createdAt = now.mul(1000);
    }
}
