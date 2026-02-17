// 08_Routes
const express = require("express");
const router = express.Router();

/*

router.get("/about", (req, res) => {
  res.render("about", { txt_title: "About" });
});

router.get("/", (req, res) => {
  res.render("index", { txt_title: "Index" });
});

*/

// 09_Routes_with_Controller
const newsiteController = require("../controllers/about");

router.get("/about", newsiteController);

router.get("/", (req, res) => {
  res.render("index", { txt_title: "Index" });
});

module.exports = router;
