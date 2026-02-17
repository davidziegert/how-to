let prefers = window.matchMedia("(prefers-color-scheme: dark)").matches ? "dark" : "light";
let mobile = window.matchMedia("(max-width: 767px)");
let desktop = window.matchMedia("(min-width: 1024px)");

const header_logo = document.getElementById("header-logo");
const nav_logo = document.getElementById("nav-logo");

if (mobile.matches) {
  header_logo.src = "./assets/images/favicon.svg";
}

if (desktop.matches) {
  switch (prefers) {
    case "dark":
      nav_logo.src = "./assets/images/logo_dark.svg";
      break;
    case "light":
      nav_logo.src = "./assets/images/logo_light.svg";
      break;
  }
}
