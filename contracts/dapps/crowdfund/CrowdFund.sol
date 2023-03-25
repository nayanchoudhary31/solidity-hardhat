// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import {IERC20} from "./IERC20.sol";

/**
 * @title CrowdFund Dapps
 * @author iamnayan31
 */
contract CrowdFund {
    struct Campaign {
        address creator;
        uint256 goal;
        uint256 pledged;
        uint32 startAt;
        uint32 endAt;
        bool claimed;
    }

    mapping(uint256 => Campaign) public campaigns;
    mapping(uint256 => mapping(address => uint256)) public pledgeAmounts;

    IERC20 public immutable token;
    uint256 public counterId;

    event CampaignCreated(
        uint256 Id,
        address indexed creator,
        uint256 goalAmount,
        uint256 startTime,
        uint256 endTime
    );

    event CampaignCanceled(uint256 Id, address indexed creator);
    event Pledged(uint256 Id, address indexed sender, uint256 amount);
    event Unpledged(uint256 Id, address indexed sender, uint256 amount);
    event Claimed(uint256 Id, address indexed sender, uint256 amount);
    event Refunded(uint256 Id, address indexed sender, uint256 amount);

    constructor(IERC20 _token) {
        token = _token;
    }

    /**
     * @notice Help the user to start the campaign
     * @param _goal amount user want to raise
     * @param _startAt start time of the campaign
     * @param _endAt end time of the campaign
     */
    function start(uint256 _goal, uint32 _startAt, uint32 _endAt) external {
        require(_startAt >= block.timestamp, "Start Time is Passed Already");
        require(_endAt >= _startAt, "End Time is < Start Time");
        require(
            _endAt <= block.timestamp + 90 days,
            "Campaign Not Expired Yet"
        );
        counterId++;
        campaigns[counterId] = Campaign({
            creator: msg.sender,
            goal: _goal,
            pledged: 0,
            startAt: _startAt,
            endAt: _endAt,
            claimed: false
        });

        emit CampaignCreated(counterId, msg.sender, _goal, _startAt, _endAt);
    }

    /**
     * @notice Help the campaign creator to cancel the campaign
     * @param _id user need to give campaign Id
     */
    function cancel(uint256 _id) external {
        Campaign memory c = campaigns[_id];
        require(
            msg.sender == c.creator,
            "User is not creator for this campaign"
        );
        require(block.timestamp < c.startAt, "Campaign Started");

        delete campaigns[_id];

        emit CampaignCanceled(_id, c.creator);
    }

    /**
     * @notice Help the contributor to contribute in the campaign
     * @param _id user need to give campaign Id
     * @param amount user need to give amount
     */

    function pledge(uint256 _id, uint256 amount) external {
        Campaign storage c = campaigns[_id];
        require(block.timestamp >= c.startAt, "Campaign Not Started");
        require(block.timestamp <= c.endAt, "Campaign is Finished");
        c.pledged += amount;
        pledgeAmounts[_id][msg.sender] += amount;
        token.transferFrom(msg.sender, address(this), amount);

        emit Pledged(_id, msg.sender, amount);
    }

    /**
     * @notice Help the contributor to remove the contribution in the campaign
     * @param _id user need to give campaign Id
     * @param amount user need to give amount
     */

    function unpledge(uint256 _id, uint256 amount) external {
        Campaign storage c = campaigns[_id];
        require(block.timestamp <= c.endAt, "Campaign is Finished");
        c.pledged -= amount;
        pledgeAmounts[_id][msg.sender] -= amount;
        token.transfer(msg.sender, amount);
        emit Unpledged(_id, msg.sender, amount);
    }

    /**
     * @notice Help the campaign creator to claim the goal amount
     * @param _id Need to give campaign Id
     */
    function claim(uint256 _id) external {
        Campaign storage c = campaigns[_id];
        require(msg.sender == c.creator, "Not Creator");
        require(block.timestamp > c.endAt, "Campaign Not Expired Yet");
        require(c.pledged >= c.goal, "Pledged Amount < Goal Amount");
        require(!c.claimed, "Already Claimed");

        c.claimed = true;

        token.transfer(msg.sender, c.pledged);

        emit Claimed(_id, msg.sender, c.pledged);
    }

    /**
     * @notice Help the user to claim back the token
     * @param _id Need to give campaign Id
     */
    function refund(uint256 _id) external {
        Campaign storage c = campaigns[_id];
        require(block.timestamp > c.endAt, "Campaign Not Expired Yet");
        require(c.pledged < c.goal, "Pledged Amount > Goal Amount");

        uint256 bal = pledgeAmounts[_id][msg.sender];
        pledgeAmounts[_id][msg.sender] = 0;
        token.transfer(msg.sender, bal);
        emit Refunded(_id, msg.sender, bal);
    }
}
