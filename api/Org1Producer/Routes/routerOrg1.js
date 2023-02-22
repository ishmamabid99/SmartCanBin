const {
  invoke,
  query,
  addManufactureData,
} = require("../controllers/Org1Controller");
const { EnrollUser } = require("../registerEnrollClientUserOrg1");

const router = require("express").Router();

router.post("/enroll", EnrollUser);
router.post("/invoke", invoke);
router.post("/addManufactureData", addManufactureData);
router.get("/query/:user", query);

module.exports = router;
