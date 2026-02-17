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

// 04_Logging_Requests_with_Morgan
const morgan = require("morgan");
app.use(morgan("dev"));

// 05_Include_Static_Files
app.use(express.static("public"));

// 06_Request_JSON-Formats
app.use(express.json());
app.use(express.urlencoded({ extended: false }));

// 07_Helmet-HTTP-Security
const helmet = require("helmet");
app.use(helmet());

// 08_Routes
const routes = require("./routes/route");
app.use(routes);

// 09_Route_Errors
app.use((req, res) => {
  res.status(403).render("403", { txt_title: "Status: 403 - Forbidden" });
});

app.use((req, res) => {
  res.status(404).render("404", { txt_title: "Status: 404 - Not Found" });
});

app.use((req, res) => {
  res.status(500).render("500", { txt_title: "Status: 500 - Internal Server Error" });
});

app.use((req, res) => {
  res.status(502).render("502", { txt_title: "Status: 502 - Bad Gateway" });
});

// 10_Start_Server
app.listen(port, url, () => {
  console.log("Server running since: " + timestamp + " at - http://" + url + ":" + port);
});
