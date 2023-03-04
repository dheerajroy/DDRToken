const DDRToken = artifacts.require('DDRToken')

module.exports = (deployer) => {
    deployer.deploy(DDRToken)
}