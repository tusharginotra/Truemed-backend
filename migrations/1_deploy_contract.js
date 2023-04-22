var medicineList = artifacts.require('MedicineList')
var shipmentList = artifacts.require('ShipmentList')

module.exports = function(deployer){
    deployer.deploy(medicineList)
    deployer.deploy(shipmentList)
}