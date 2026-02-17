// 01_ExpressServer
const express = require("express");
const app = express();
const url = "localhost";
const port = 5005;

// 02_Moment
const moment = require("moment");
const timestamp = moment().format("llll");

// 03_ViewsEngine_with_EJS
app.set("view engine", "ejs");
app.set("views", "views");

// 04_Start_Server
app.listen(port, url);
console.log("Server running since " + timestamp + " at - http://" + url + ":" + port);

// 05_Logging_Requests_with_Morgan
const morgan = require("morgan");
app.use(morgan("dev"));

// 06_Include_Static_Files
app.use(express.static("public"));

// 07_Server_Request_with_Views
app.get("/", (req, res) => {
  res.render("index", { txt_title: "Home" });
});
app.use((req, res) => {
  res.status(404).render("404", { txt_title: "Error: 404" });
});
