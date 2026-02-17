function openMenu() {
  const hamburger = document.getElementById("header-hamburger");
  const nav_logo = document.getElementById("nav-logo");

  const header = document.getElementById("header");
  const nav = document.getElementById("nav");
  const main = document.getElementById("main");
  const footer = document.getElementById("footer");

  let desktop = window.matchMedia("(min-width: 1024px)");

  hamburger.classList.toggle("open");
  nav.classList.toggle("open");

  if (desktop.matches) {
    if (nav.classList.contains("open")) {
      nav_logo.src = "./assets/images/favicon.svg";
    } else {
      switch (prefers) {
        case "dark":
          nav_logo.src = "./assets/images/logo_dark.svg";
          break;
        case "light":
          nav_logo.src = "./assets/images/logo_light.svg";
          break;
      }
    }
  }

  if (desktop.matches) {
    if (nav.classList.contains("open")) {
      nav.style.width = "100px";
      header.style.marginLeft = "100px";
      main.style.marginLeft = "100px";
      footer.style.marginLeft = "100px";
    } else {
      nav.style.width = "250px";
      header.style.marginLeft = "250px";
      main.style.marginLeft = "250px";
      footer.style.marginLeft = "250px";
    }
  }
}
