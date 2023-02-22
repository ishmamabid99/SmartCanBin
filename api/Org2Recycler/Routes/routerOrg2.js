const {
  invoke,
  query,
  recordAluminiumCanRecycle,
} = require("../controllers/Org2Controller");
const { EnrollUser } = require("../registerEnrollClientUserOrg2");

const router = require("express").Router();

router.post("/enroll", EnrollUser);
router.post("/invoke", invoke);
router.post("/addData", recordAluminiumCanRecycle);
router.get("/query/:user", query);
module.exports = router;
