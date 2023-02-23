const path = require("path");
const fs = require("fs");
const crypto = require("crypto");
const { Wallets } = require("fabric-network");
const jwt = require("jsonwebtoken");
const TOKEN_KEY = require("../../env/env");
module.exports.Login = async (req, res) => {
  try {
    const username = req.body.user;
    const password = req.body.password;
    let user = crypto
      .createHash("sha256")
      .update(username + password)
      .digest("hex")
      .toString();

    const ccpPath = path.resolve(__dirname, "connection-org1.json");
    const ccp = JSON.parse(fs.readFileSync(ccpPath, "utf-8"));
    const walletPath = path.join(process.cwd(), "walletOrg1");
    const wallet = await Wallets.newFileSystemWallet(walletPath);
    console.log(`Wallet path: ${walletPath}`);
    const identity = await wallet.get(user);
    console.log("OK 1");
    if (!identity) {
      return res.status(202).json(`User not found`);
    }
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
  } catch (err) {
    console.log(err);
    return res.status(404).json(`${err}`);
  }
};
