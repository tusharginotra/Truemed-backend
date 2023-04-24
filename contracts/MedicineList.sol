// SPDX-License-Identifier: UNLICENSED
pragma solidity <=0.8.19;

contract MedicineList{
    uint public numberOfMedicines = 0;
    mapping(uint => Medicine) public listOfMedicines;
    struct Medicine{
        uint medicineId;
        string medicineName;
        string brandName;
        string medicineType;
        string ndcNumber;
    }
    function addMedicine(string memory newMedicineName, string memory brandName, string memory medicineType, string memory ndcNumber) public{
        numberOfMedicines = numberOfMedicines + 1;
        listOfMedicines[numberOfMedicines] = Medicine(numberOfMedicines, newMedicineName, brandName, medicineType, ndcNumber);
    }
    function deleteMedicine(uint medicineId) public{
        delete listOfMedicines[medicineId];
    }
}

