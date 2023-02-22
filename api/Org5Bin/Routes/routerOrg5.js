const { EnrollUser } = require("../registerEnrollClientUserOrg5");

const router = require("express").Router();

router.post("/enroll", EnrollUser);

module.exports = router;
