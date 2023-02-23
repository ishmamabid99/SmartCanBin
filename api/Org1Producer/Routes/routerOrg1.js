const {
  invoke,
  query,
  addManufactureData,
} = require("../controllers/Org1Controller");
const { Login } = require("../LoginController");
const { EnrollUser } = require("../registerEnrollClientUserOrg1");

const router = require("express").Router();

router.post("/enroll", EnrollUser);
router.post("/invoke", invoke);
router.post("/addManufactureData", addManufactureData);
router.post("/test", async (req, res) => {
  console.log(req);
  const user = req.body.user;
  console.log(user);
});
router.post("/login", Login);
router.get("/query/:user", query);

module.exports = router;
