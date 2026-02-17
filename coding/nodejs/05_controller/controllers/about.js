// 09_Routes_with_Controller
const jsonView = (req, res) => {
  res.render("about", { txt_title: "About" });
};

module.exports = jsonView;
