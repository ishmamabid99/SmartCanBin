const { query, addSegregateData } = require("../controllers/Org6Controller");
const { EnrollUser } = require("../registerEnrollClientUserOrg6");

const router = require("express").Router();

router.post("/enroll", EnrollUser);
router.post("/addsegregatedata", addSegregateData);
router.get("/query/:user", query);

module.exports = router;
