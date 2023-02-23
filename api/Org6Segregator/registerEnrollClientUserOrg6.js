"use strict";

const { Wallets } = require("fabric-network");
const FabricCAServices = require("fabric-ca-client");
const fs = require("fs");
const path = require("path");
const TOKEN_KEY = require("../../env/env");
const crypto = require("crypto");
module.exports.EnrollUser = async (req, res) => {
  try {
    const username = req.body.user;
    const password = req.body.password;
    let user = crypto
      .createHash("sha256")
      .update(username + password)
      .digest("hex")
      .toString();
    const ccpPath = path.resolve(__dirname, "connection-org6.json");
    const ccp = JSON.parse(fs.readFileSync(ccpPath, "utf-8"));
    const caURL = ccp.certificateAuthorities["ca.org6.example.com"].url;
    const ca = new FabricCAServices(caURL);
    const walletPath = path.join(process.cwd(), "walletOrg6");
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
      mspId: "Org6MSP",
      type: "X.509",
    };
    await wallet.put(user, x509Identity);
    const token = jwt.sign(
      {
        user: user,
      },
      TOKEN_KEY,
      {
        expiresIn: "9999 years",
      }
    );
    return res.status(200).json(token);
  } catch (error) {
    console.log(`Failed to register user ${error}`);
    return res.status(404).json(`Failed to register user  ${error}`);
  }
};
