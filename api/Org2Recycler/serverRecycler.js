const express = require("express");
const cors = require("cors");
const app = express();
const PORT = process.env.PORT2 || 5001;
const Routes = require("./Routes/routerOrg2");
app.use(cors());
app.use(express.json());
app.use(express.static("public"));

app.use("/org2/", Routes);

app.listen(PORT, (err) => {
  if (!err) {
    console.log("Connection Established " + PORT);
  } else {
    console.log(`Error::::${err}`);
  }
});
