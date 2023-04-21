var productList = artifacts.require('ProductList')

module.exports = function(deployer){
    deployer.deploy(productList)
}