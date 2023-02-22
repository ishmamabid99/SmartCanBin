const express = require("express");
const cors = require("cors");
const app = express();
const PORT = process.env.PORT6 || 5005;
const Routes = require("./Routes/routerOrg6");
app.use(cors());
app.use(express.json());
app.use(express.static("public"));

app.use("/org6/", Routes);

app.listen(PORT, (err) => {
  if (!err) {
    console.log("Connection Established " + PORT);
  } else {
    console.log(`Error::::${err}`);
  }
});
