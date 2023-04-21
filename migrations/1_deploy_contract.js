var medicineList = artifacts.require('MedicineList')

module.exports = function(deployer){
    deployer.deploy(medicineList)
}