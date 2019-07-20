pragma solidity ^0.5.0;

import "./openzeppelin/lifecycle/Killable.sol";
import "./openzeppelin/math/SafeMath.sol";

contract BloodChain is Killable {
    using SafeMath for uint256;

    string constant CONTRACT_INFO = "Blood Chain Contract";

    function getInfo() public pure returns (string memory) {
        return CONTRACT_INFO;
    }

    function sendFund() public payable onlyOwner { }

    function withdraw(uint amount) public payable onlyOwner {
        require (amount <= address(this).balance, "Not enough ETH");
        _owner.transfer(amount);
    }
}
