// SPDX-License-Identifier: UNLICENSED
pragma solidity <=0.8.19;

contract MedicineList{
    uint public numberOfMedicines = 0;
    mapping(uint => Medicine) public listOfMedicines;
    struct Medicine{
        uint medicineId;
        string medicineName;
    }
    function addMedicine(string memory newMedicineName ) public{
        numberOfMedicines = numberOfMedicines + 1;
        listOfMedicines[numberOfMedicines] = Medicine(numberOfMedicines, newMedicineName);
    }
}

