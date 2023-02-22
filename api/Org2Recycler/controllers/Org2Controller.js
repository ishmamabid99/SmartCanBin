const { SetConnection, closeConnection } = require("../connectionManageOrg2");

module.exports.invoke = async (req, res) => {
  try {
    const userName = req.body.user;
    const data = await SetConnection(userName);
    const result = await data.contract.submitTransaction(
      "createCar",
      req.body.carName,
      req.body.carModel,
      req.body.carAccord,
      req.body.carColor,
      req.body.carOwner
    );
    console.log("Transaction Has been Submitted");
    res.status(200).json(result);
    closeConnection(userName);
  } catch (err) {
    console.log(`${err}`);
    return res.status(404).json(`${err}`);
  }
};
module.exports.query = async (req, res) => {
  try {
    userName = req.params.user;
    const data = await SetConnection(userName);
    const result = await data.contract.evaluateTransaction("queryAllData");
    console.log("Data is fetched");
    res.status(200).json(JSON.parse(result.toString()));
  } catch (err) {
    console.log(`${err}`);
    return res.status(404).json(`${err}`);
  }
};

module.exports.recordAluminiumCanRecycle = async (req, res) => {
  try {
    const user = req.body.user;
    const { canId, recycler, chemicals } = req.body;
    const data = await SetConnection(user);
    const timeStamp = new Date().getTime();
    const result = await data.contract.submitTransaction(
      "recordAluminiumCanRecycle",
      canId,
      recycler,
      timeStamp,
      chemicals
      // target
    );
    console.log("Data is fetched");
    res.status(200).json(`${result}`);
    closeConnection(user);
  } catch (err) {
    console.log(`${err}`);
    return res.status(404).json(`${err}`);
  }
};
