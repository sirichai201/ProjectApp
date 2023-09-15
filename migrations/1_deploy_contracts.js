const UniversityAuthentication = artifacts.require("MyContract");

module.exports = function (deployer) {
    deployer.deploy(UniversityAuthentication);
};