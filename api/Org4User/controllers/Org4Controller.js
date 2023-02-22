const { SetConnection, closeConnection } = require("../connectionManageOrg4");

module.exports.query = async (req, res) => {
  try {
    const user = req.params.user;
    const data = await SetConnection(user);
    const result = await data.contract.evaluateTransaction("queryAllData");
    console.log("Data is fetched Successfully");
    res.status(200).json(result.toString());
    closeConnection(user);
  } catch (err) {
    console.log(err);
    return res.status(404).json(`${err}`);
  }
};
module.exports.addCanUsageData = async (req, res) => {
  try {
    const user = req.body.user;
    const { userId, canId, batchNo } = req.body;
    const data = await SetConnection(user);
    const timeStamp = new Date().getTime();
    const result = await data.contract.submitTransaction(
      "recordAluminumCanUsage",
      userId,
      canId,
      timeStamp,
      batchNo
    );
    return res.status(200).json(result.toString());
  } catch (err) {
    console.log(err);
    return res.status(404).json(`${err}`);
  }
};
