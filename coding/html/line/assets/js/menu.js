let mediaquery = window.matchMedia("(max-width: 1279px)");
let list = document.querySelectorAll(".menu-item-has-children");
let crawler = document.querySelector(".current-page-item");

if (mediaquery.matches) {
  if (crawler != null) {
    crawler.parentNode.parentNode.classList.add("active");
    crawler.parentNode.parentNode.parentNode.parentNode.classList.add("active");
  }

  for (i = 0; i < list.length; i++) {
    list[i].addEventListener("click", accordion);
  }

  function accordion(e) {
    e.stopPropagation();

    if (this.classList.contains("active")) {
      this.classList.remove("active");
    } else {
      if (this.parentElement.parentElement.classList.contains("active")) {
        for (i = 0; i < list.length; i++) {
          list[i].classList.remove("active");
        }

        this.parentElement.parentElement.classList.add("active");
        this.classList.add("active");
      } else {
        this.parentElement.parentElement.classList.add("active");
        this.classList.add("active");
      }
    }
  }
}
