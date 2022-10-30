// SPDX-License-Identifier: MIT

// 10 токенов за заполнение первой коллекции из 6 НФТ
// 5 токенов за приведенного друга (обоим), учитывать в ограничении 100 дневных
// 1 токен в подарок, если прошел всю обучалку

pragma solidity ^0.8.0;

import "./TinToken.sol";

contract ImportRewards is TinToken {
    uint256 public firstCollectionBonus = 10 ether;
    uint256 public invitedFriendBonus = 5 ether;
    uint256 public completedStudyBonus = 1 ether;

    function firstCollectionReward(address _user) public {
        TinToken.transferFrom(thisOwner, _user, firstCollectionBonus);
    }

    function completedStudyReward(address _user) public {
        TinToken.transferFrom(thisOwner, _user, completedStudyBonus);
    }

    function invitedFriendReward(address _user, address _newUser) public {
        invitedFriendUser(_user);
        invitedFriendNewUser(_newUser);
    }

    function invitedFriendUser(address _user) internal {
        TinToken.transferFrom(thisOwner, _user, invitedFriendBonus);
    }

    function invitedFriendNewUser(address _newUser) internal {
        TinToken.transferFrom(thisOwner, _newUser, invitedFriendBonus);
    }
}
