// SPDX-License-Identifier: MIT

// 10 токенов за заполнение первой коллекции из 6 НФТ
// 5 токенов за приведенного друга (обоим), учитывать в ограничении 100 дневных
// 1 токен в подарок, если прошел всю обучалку

pragma solidity ^0.8.0;

contract CallRewards {
    uint256 public firstCollectionBonus = 10 ether;
    uint256 public invitedFriendBonus = 5 ether;
    uint256 public completedStudyBonus = 1 ether;

    function firstCollectionReward(address TinToken, address _user) external {
        (bool success, ) = TinToken.call(
            abi.encodeWithSignature(
                "transferFrom(address,address,uint256)",
                thisOwner,
                _user,
                firstCollectionBonus
            )
        );
        require(success, "Transaction failed");
    }

    function completedStudyReward(address TinToken, address _user) public {
        (bool success, ) = TinToken.call(
            abi.encodeWithSignature(
                "transferFrom(address,address,uint256)",
                thisOwner,
                _user,
                completedStudyBonus
            )
        );
        require(success, "Transaction failed");
    }

    function invitedFriendReward(address _user, address _newUser) public {
        invitedFriendUser(_user);
        invitedFriendNewUser(_newUser);
    }

    function invitedFriendUser(address TinToken, address _user) internal {
        (bool success, ) = TinToken.call(
            abi.encodeWithSignature(
                "transferFrom(address,address,uint256)",
                thisOwner,
                _user,
                invitedFriendBonus
            )
        );
        require(success, "Transaction failed");
    }

    function invitedFriendNewUser(address TinToken, address _newUser) internal {
        (bool successNew, ) = TinToken.call(
            abi.encodeWithSignature(
                "transferFrom(address,address,uint256)",
                thisOwner,
                _newUser,
                invitedFriendBonus
            )
        );
        require(successNew, "Transaction failed");
    }
}