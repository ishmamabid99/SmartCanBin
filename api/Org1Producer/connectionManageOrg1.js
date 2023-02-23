const path = require("path");
const fs = require("fs");
const { Gateway, Wallets } = require("fabric-network");

module.exports.SetConnection = async (username) => {
  try {
    const ccpPath = path.resolve(__dirname, "connection-org1.json");
    const ccp = JSON.parse(fs.readFileSync(ccpPath, "utf-8"));
    const walletPath = path.join(process.cwd(), "walletOrg1");
    const wallet = await Wallets.newFileSystemWallet(walletPath);
    console.log(`Wallet path: ${walletPath}`);

    // Check to see if we've already enrolled the user.
    const identity = await wallet.get(username);
    console.log("OK 1");

    if (!identity) {
      console.log(
        `An identity for the user "${username}" does not exist in the wallet`
      );
      console.log("Run the registerUser.js application before retrying");
      throw new Error(
        `An identity for the user ${username.toUpperCase()} does not exist in the wallet`
      );
      return;
    }

    console.log("OK 2");
    // Create a new gateway for connecting to our peer node.
    const gateway = new Gateway();
    console.log("OK 3");

    await gateway.connect(ccp, {
      wallet,
      identity: username,
      discovery: {
        enabled: true,
        asLocalhost: true,
      },
    });
    console.log("OK 4");
    // Get the network (channel) our contract is deployed to.
    const network = await gateway.getNetwork("test-channel");

    // Get the contract from the network.
    console.log("OK 5");
    const contract = network.getContract("test");

    const data = { gateway, network, contract };
    return data;
  } catch (err) {
    console.log(`You have encountered an error : ${err}`);
    return err;
  }
};
module.exports.closeConnection = async (data) => {
  try {
    await data.gateway.disconnect();
  } catch (error) {
    return error;
  }
};
