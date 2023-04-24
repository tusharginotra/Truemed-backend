// SPDX-License-Identifier: UNLICENSED
pragma solidity <=0.8.19;

contract UserList{
    struct User{
        address userAddress;
        string userType;
    }
    mapping(address=>User) listOfUsers;

    function login(string memory userType) public{
        listOfUsers[msg.sender] = User(msg.sender, userType);
    }
    function getType() public view returns(string memory){
        return listOfUsers[msg.sender].userType;
    }

    function getUserType(address userAddress) public view returns(string memory){
        return listOfUsers[userAddress].userType;
    }

    function verifyUser() public view returns(bool){
        if(listOfUsers[msg.sender].userAddress == address(0)) return false;
        return true;
    }

}