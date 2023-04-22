var medicineList = artifacts.require('MedicineList')
var shipmentList = artifacts.require('ShipmentList')
var userList = artifacts.require('UserList')

module.exports = function(deployer){
    deployer.deploy(medicineList)
    deployer.deploy(shipmentList)
    deployer.deploy(userList)
}