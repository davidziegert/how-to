function openMenu() {
  let mediaquery = window.matchMedia("(max-width: 1023px)");
  const hamburger = document.getElementById("header-hamburger");
  const nav = document.getElementById("nav");

  if (mediaquery.matches) {
    hamburger.classList.toggle("open");
    nav.classList.toggle("open");
  }
}
