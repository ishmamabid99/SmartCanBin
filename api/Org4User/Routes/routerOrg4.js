const { addCanUsageData, query } = require("../controllers/Org4Controller");
const { EnrollUser } = require("../registerEnrollClientUserOrg4");

const router = require("express").Router();

router.post("/enroll", EnrollUser);
router.post("/addcanusagedata", addCanUsageData);
router.get("/query/:user", query);
module.exports = router;
