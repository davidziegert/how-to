// MongoDB & Mongoose Server starten
const mongoose = require("mongoose");
const mongodbURI = "mongodb://localhost:27017/db_mongo?authMechanism=DEFAULT";
const Movies = require("../models/mongodb");

mongoose
  .connect(mongodbURI)
  .then(() => console.log("MongoDB-Connection: has been established successfully."))
  .catch((error) => console.log("MongoDB-Connection failed:", error));

exports.viewAllMovies = (req, res) => {
  Movies.find()
    .then((movies) => {
      res.render("mongodb", { txt_title: "MongoDB-Movies", data: movies });
    })
    .catch((error) => {
      console.log(error);
    });
};

exports.viewPostMovie = (req, res) => {
  res.render("mongodb_add", { txt_title: "MongoDB-Movies: Add" });
};

exports.viewUpdateMovie = (req, res) => {
  const id = req.params.id;

  Movies.findById(id)
    .then((movie) => {
      res.render("mongodb_update", { txt_title: "MongoDB-Movies: Update", data: movie });
    })
    .catch((error) => {
      console.log(error);
    });
};

exports.postSingleMovie = (req, res) => {
  const movie = new Movies({ _year: req.body.year, _title: req.body.title, _description: req.body.description });

  movie
    .save()
    .then(() => {
      res.redirect("/mongodb");
    })
    .catch((error) => {
      console.log(error);
    });
};

exports.updateSingleMovie = (req, res) => {
  Movies.findOneAndUpdate({ _id: req.body.id }, { _year: req.body.year, _title: req.body.title, _description: req.body.description }, { new: true })
    .then(() => {
      res.redirect("/mongodb");
    })
    .catch((error) => {
      console.log(error);
    });
};

exports.deleteSingleMovie = (req, res) => {
  Movies.findByIdAndDelete({ _id: req.body.id })
    .then(() => {
      res.redirect("/mongodb");
    })
    .catch((error) => {
      console.log(error);
    });
};
