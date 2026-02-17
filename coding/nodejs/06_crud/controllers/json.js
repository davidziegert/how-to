// Access JSON-Files from Path
const fs = require("fs");
const path = require("path");
const root = path.resolve("./");
const filepath = path.join(root, "data", "movies.json");
const crypto = require("crypto");

// Helper
const loadData = () => {
  const file = fs.readFileSync(filepath, "utf8");
  return JSON.parse(file);
};

const saveData = (data) => {
  const inputData = JSON.stringify(data);
  fs.writeFileSync(filepath, inputData);
};

exports.viewAllMovies = (req, res) => {
  try {
    const movies = loadData();
    res.render("json", { txt_title: "JSON-Movies", data: movies });
  } catch (error) {
    console.log(error);
  }
};

exports.viewPostMovie = (req, res) => {
  try {
    res.render("json_add", { txt_title: "JSON-Movies: Add" });
  } catch (error) {
    console.log(error);
  }
};

exports.viewUpdateMovie = (req, res) => {
  const id = req.params.id;

  try {
    const movies = loadData();
    const movie = movies.find((x) => x._id === id);
    res.render("json_update", { txt_title: "JSON-Movies: Update", data: movie });
  } catch (error) {
    console.log(error);
  }
};

exports.postSingleMovie = (req, res) => {
  const newID = crypto.randomBytes(8).toString("hex");
  const newData = {
    _id: newID,
    _title: req.body.title,
    _year: Number(req.body.year),
    _description: req.body.description,
  };

  try {
    let movies = loadData();
    movies.push(newData);
    saveData(movies);
  } catch (error) {
    console.log(error);
  } finally {
    res.redirect("/json");
  }
};

exports.updateSingleMovie = (req, res) => {
  const id = req.body.id;
  const newData = {
    _id: req.body.id,
    _title: req.body.title,
    _year: Number(req.body.year),
    _description: req.body.description,
  };

  try {
    let movies = loadData();
    const index = movies.indexOf(movies.find((x) => x._id === id));
    movies.splice(index, 1);
    movies.splice(index, 0, newData);
    saveData(movies);
  } catch (error) {
    console.log(error);
  } finally {
    res.redirect("/json");
  }
};

exports.deleteSingleMovie = (req, res) => {
  const id = req.body.id;

  try {
    let movies = loadData();
    const index = movies.indexOf(movies.find((x) => x._id === id));
    movies.splice(index, 1);
    saveData(movies);
  } catch (error) {
    console.log(error);
  } finally {
    res.redirect("/json");
  }
};
