// SPDX-License-Identifier: UNLICENSED
pragma solidity <=0.8.19;

contract ShipmentList{
    mapping(uint=>uint) public numberOfShipments;
    uint public numberOfChains = 0;
    mapping(uint => mapping(uint=>Shipment)) public listOfShipments;
    struct Shipment{
        uint chainId;
        uint shipmentId;
        uint medicineId;
        address senderId;
        address recieverId;
        uint256 sendingTime;
        string deliveryStatus;
        bool transactionStatus;
    }
    function createShipment(bool newShipment, uint chainId, uint medicineId, address recieverId, string memory deliveryStatus) public{
        // mapping(uint=> address) senderIds;
        // mapping(uint=> uint256) sendingTimes = {};
        address senderId = msg.sender;
        uint256 sendingTime = block.timestamp;
        if(newShipment==true){
            numberOfChains = numberOfChains+1;
            numberOfShipments[numberOfChains]++;
            listOfShipments[numberOfChains][numberOfShipments[numberOfChains]] = Shipment(numberOfChains, numberOfShipments[numberOfChains], medicineId, senderId, recieverId, sendingTime, deliveryStatus, false);
        }else{
            numberOfShipments[chainId]++;
            listOfShipments[chainId][numberOfShipments[chainId]] = Shipment(chainId, numberOfShipments[chainId], medicineId, senderId, recieverId, sendingTime, deliveryStatus, false);
        }
    }

    function deleteShipment(uint chainId, uint shipmentId) public{
        delete listOfShipments[chainId][shipmentId];
    }

    function deleteChain(uint chainId) public{
        for(uint i = 0;i < numberOfShipments[chainId];i++){
            delete listOfShipments[chainId][i+1];
        }
    }

    function updateDeliveryStatus(uint chainId, uint shipmentId, string memory deliveryStatus) public {
        listOfShipments[chainId][shipmentId].deliveryStatus = deliveryStatus;
    }
    function setTransactionComplete(uint chainId, uint shipmentId) public{
        listOfShipments[chainId][shipmentId].transactionStatus = true;
    }
    function setVerified(uint chainId, uint shipmentId) public{
        listOfShipments[chainId][shipmentId].transactionStatus = true;
    }
    // 0 for original unverified product
    // 1 for shipment does not exist
    // 2 for already verified product
    // 3 for authentication error
    function getVerificationResult(uint chainId, uint shipmentId, address account) public view returns(uint){
        if(listOfShipments[chainId][shipmentId].recieverId!=account && listOfShipments[chainId][shipmentId].recieverId!=address(0)){
            return 3;
        }
        if(listOfShipments[chainId][shipmentId].transactionStatus==true){
            return 2;
        }
        if(listOfShipments[chainId][shipmentId].senderId==address(0)){
            return 1;
        }
        else{
           return 0;
        }
    }
    function allowOpenSelling(uint chainId, uint shipmentId) public {
        listOfShipments[chainId][shipmentId].transactionStatus = false;
        listOfShipments[chainId][shipmentId].recieverId = address(0);
    }

}

