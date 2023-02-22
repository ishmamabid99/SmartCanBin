const { SetConnection, closeConnection } = require("../connectionManageOrg6");

module.exports.query = async (req, res) => {
  try {
    const user = req.params.user;
    const data = await SetConnection(user);
    const result = await data.contract.evaluateTransaction("queryAllData");
    console.log(
      `Transaction has been evaluated, result is: ${result.toString()}`
    );
    closeConnection(user);
    return res.status(200).json(`${result}`);
  } catch (err) {
    console.log(err);
    return res.status(404).json(`${err}`);
  }
};
module.exports.addSegregateData = async (req, res) => {
  try {
    const user = req.body.user;
    const { canId, segregator } = req.body;
    const timeStamp = new Date().getTime();
    const data = await SetConnection(user);
    const result = await data.contract.submitTransaction(
      "recordAluminiumCanSegregate",
      segregator,
      canId,
      timeStamp
    );
    closeConnection(user);
    return res.status(200).json(`${result}`);
  } catch (err) {
    console.log(err);
    return res.status(404).json(`${err}`);
  }
};
