const { SetConnection } = require("../connectionManageOrg3");

module.exports.query = async (req, res) => {
  try {
    const user = req.params.user;
    const data = await SetConnection(user);
    const result = await data.contract.evaluateTransaction("queryAllData");
    if (result) {
      return res.status(200).json(`${result.toString()}`);
    } else {
      return res.status(202).json(`Nothing to show man!!!`);
    }
  } catch (err) {
    console.log(`${err}`);
    return res.status(404).json(`${err}`);
  }
};
module.exports.addRetailerData = async (req, res) => {
  try {
    const user = req.body.user;
    const { retailer, canId } = req.body;
    const timeStamp = new Date().getTime();
    const data = await SetConnection(user);
    const result = await data.contract.submitTransaction(
      "recordAluminiumCanSale",
      retailer,
      canId,
      timeStamp
    );
    if (result.toString() === "Data written was successful") {
      return res.status(200).json(result.toString());
    } else {
      return res.status(202).json("Nothing was found");
    }
  } catch (err) {
    console.log(err);
    return res.status(404).json(`${err}`);
  }
};
