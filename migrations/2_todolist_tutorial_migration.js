// Make sure the DevToken contract is included by requireing it.
const TodolistTutorial = artifacts.require("TodolistTutorial");

// THis is an async function, it will accept the Deployer account, the network, and eventual accounts.
module.exports = async function (deployer, network, accounts) {
  // await while we deploy the DevToken
  await deployer.deploy(TodolistTutorial);
  await TodolistTutorial.deployed();
};
