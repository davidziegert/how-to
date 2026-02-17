let prefers = window.matchMedia("(prefers-color-scheme: dark)").matches ? "dark" : "light";
const logo = document.getElementById("header-logo");

switch (prefers) {
  case "dark":
    logo.src = "./assets/images/logo_dark.svg";
    break;
  case "light":
    logo.src = "./assets/images/logo_light.svg";
    break;
}
