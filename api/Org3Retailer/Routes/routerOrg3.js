const { query, addRetailerData } = require("../controllers/Org3Controller");
const { EnrollUser } = require("../registerEnrollClientUserOrg3");

const router = require("express").Router();

router.post("/enroll", EnrollUser);
router.post("/addretailerdata", addRetailerData);
router.get("/query/:user", query);
module.exports = router;
