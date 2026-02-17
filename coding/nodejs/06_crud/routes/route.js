// 08_Routes
const express = require("express");
const router = express.Router();

const jsonController = require("../controllers/json");
const mysqlController = require("../controllers/mysql");
const mongodbController = require("../controllers/mongodb");

// Route: JSON
router.get("/json", jsonController.viewAllMovies);
router.get("/json/add", jsonController.viewPostMovie);
router.get("/json/:id", jsonController.viewUpdateMovie);
router.post("/json", jsonController.postSingleMovie);
router.post("/json/update", jsonController.updateSingleMovie);
router.post("/json/delete", jsonController.deleteSingleMovie);

// Route: MongoDB
router.get("/mongodb", mongodbController.viewAllMovies);
router.get("/mongodb/add", mongodbController.viewPostMovie);
router.get("/mongodb/:id", mongodbController.viewUpdateMovie);
router.post("/mongodb", mongodbController.postSingleMovie);
router.post("/mongodb/update", mongodbController.updateSingleMovie);
router.post("/mongodb/delete", mongodbController.deleteSingleMovie);

// Route: MySQL
router.get("/mysql", mysqlController.viewAllMovies);
router.get("/mysql/add", mysqlController.viewPostMovie);
router.get("/mysql/:id", mysqlController.viewUpdateMovie);
router.post("/mysql", mysqlController.postSingleMovie);
router.post("/mysql/update", mysqlController.updateSingleMovie);
router.post("/mysql/delete", mysqlController.deleteSingleMovie);

// Route: Index
router.get("/", (req, res) => {
  res.render("index", { txt_title: "Home" });
});

module.exports = router;
