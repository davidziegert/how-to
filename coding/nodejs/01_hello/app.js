// 01_ExpressServer
const express = require("express");
const app = express();
const url = "localhost";
const port = 5005;

// 02_Moment
const moment = require("moment");
const timestamp = moment().format("llll");

// 03_Start_Server
app.listen(port, url);
console.log("Server running since " + timestamp + " at - http://" + url + ":" + port);

// 04_Server_Request
app.get("/", (req, res) => {
  res.send("Hello World");
});
