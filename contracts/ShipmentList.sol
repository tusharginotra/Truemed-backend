// SPDX-License-Identifier: UNLICENSED
pragma solidity <=0.8.19;

contract ShipmentList{
    uint public numberOfShipments = 0;
    mapping(uint => Shipment) public listOfShipments;
    struct Shipment{
        uint shipmentId;
        uint medicineId;
        address senderId;
        address recieverId;
        uint256 sendingTime;
        string deliveryStatus;
        bool transactionStatus;
    }
    function createShipment(uint medicineId, address recieverId, string memory deliveryStatus) public{
        // mapping(uint=> address) senderIds;
        // mapping(uint=> uint256) sendingTimes = {};
        numberOfShipments = numberOfShipments + 1;
        address senderId = msg.sender;
        uint256 sendingTime = block.timestamp;
        listOfShipments[numberOfShipments] = Shipment(numberOfShipments, medicineId, senderId, recieverId, sendingTime, deliveryStatus, false);
    }

    function deleteShipment(uint shipmentId) public{
        delete listOfShipments[shipmentId];
    }
    function updateDeliveryStatus(uint shipmentId, string memory deliveryStatus) public {
        listOfShipments[shipmentId].deliveryStatus = deliveryStatus;
    }
    function setTransactionComplete(uint shipmentId) public{
        listOfShipments[shipmentId].transactionStatus = true;
    }
    function verifyShipment(uint shipmentId) public view returns(bool){
        Shipment memory shipment = listOfShipments[shipmentId];
        if(shipment.recieverId==address(0)){
            if(shipment.transactionStatus==true) return false;
            else{
                shipment.transactionStatus = true;
                return true;
            }
        }else{
            if(shipment.recieverId==msg.sender){
                if(shipment.transactionStatus==true) return false;
                else{
                    shipment.transactionStatus = true;
                    return true;
                }
            }
        }
    }

}

