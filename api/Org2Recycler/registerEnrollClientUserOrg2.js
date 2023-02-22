"use strict";

const { Wallets } = require("fabric-network");
const FabricCAServices = require("fabric-ca-client");
const fs = require("fs");
const path = require("path");

module.exports.EnrollUser = async (req, res) => {
  try {
    const user = req.body.user;
    const ccpPath = path.resolve(__dirname, "connection-org2.json");
    const ccp = JSON.parse(fs.readFileSync(ccpPath, "utf-8"));
    const caURL = ccp.certificateAuthorities["ca.org2.example.com"].url;
    const ca = new FabricCAServices(caURL);
    const walletPath = path.join(process.cwd(), "walletOrg2");
    const wallet = await Wallets.newFileSystemWallet(walletPath);
    console.log(`Wallet path: ${walletPath}`);
    const userIdentity = await wallet.get(user);
    if (userIdentity) {
      console.log(
        `An identity for the user "${user}" already exists in the wallet`
      );
      throw new Error(
        `An identity for the user ${user.toUpperCase()} already exists in the wallet`
      );
    }
    const adminIdentity = await wallet.get("admin");
    console.log("Done");
    console.log(adminIdentity);
    if (!adminIdentity) {
      console.log(
        'An identity for the admin user "admin" does not exist in the wallet'
      );
      console.log("Run the enrollAdmin.js application before retrying");
      return;
    }
    const provider = wallet
      .getProviderRegistry()
      .getProvider(adminIdentity.type);
    const adminUser = await provider.getUserContext(adminIdentity, "admin");
    let secret;
    try {
      secret = await ca.register(
        {
          enrollmentID: user,
          enrollmentSecret: "user1pw",
          role: "client",
        },
        adminUser
      );
    } catch (error) {
      console.log(error);
      return;
    }
    const enrollment = await ca.enroll({
      enrollmentID: user,
      enrollmentSecret: secret,
    });
    const x509Identity = {
      credentials: {
        certificate: enrollment.certificate,
        privateKey: enrollment.key.toBytes(),
      },
      mspId: "Org2MSP",
      type: "X.509",
    };
    await wallet.put(user, x509Identity);
    console.log(
      `Successfully registered and enrolled user "${user}" and imported it into the wallet`
    );
    return res.status(200).json("Registered Successfully " + user);
  } catch (error) {
    console.log(`Failed to register user  ${error}`);
    return res.status(404).json(`Failed to register user  ${error}`);
  }
};
