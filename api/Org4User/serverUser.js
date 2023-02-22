const express = require("express");
const cors = require("cors");
const app = express();
const PORT = process.env.PORT4 || 5003;
const Routes = require("./Routes/routerOrg4");
app.use(cors());
app.use(express.json());
app.use(express.static("public"));

app.use("/org4/", Routes);

app.listen(PORT, (err) => {
  if (!err) {
    console.log("Connection Established " + PORT);
  } else {
    console.log(`Error::::${err}`);
  }
});
