const images = [
  {
    id: 1,
    img: "https://images.unsplash.com/photo-1626808642875-0aa545482dfb?w=750&auto=format&fit=crop&q=60",
  },
  {
    id: 2,
    img: "https://images.unsplash.com/photo-1561816544-21ecbffa09a3?w=750&auto=format&fit=crop&q=60",
  },
  {
    id: 3,
    img: "https://images.unsplash.com/photo-1578645635737-6a88e706e0f1?w=750&auto=format&fit=crop&q=60",
  },
  {
    id: 4,
    img: "https://images.unsplash.com/photo-1628076674561-6e9a0b56f2c3?w=750&auto=format&fit=crop&q=60",
  },
  {
    id: 5,
    img: "https://images.unsplash.com/photo-1617243876873-6cea4ea0b4eb?w=750&auto=format&fit=crop&q=60",
  },
  {
    id: 6,
    img: "https://images.unsplash.com/photo-1591280063444-d3c514eb6e13?w=750&auto=format&fit=crop&q=60",
  },
  {
    id: 7,
    img: "https://images.unsplash.com/photo-1546464677-c25cd52c470b?w=750&auto=format&fit=crop&q=60",
  },
  {
    id: 8,
    img: "https://images.unsplash.com/photo-1622023764342-81895b9313cc?w=750&auto=format&fit=crop&q=60",
  },
  {
    id: 9,
    img: "https://images.unsplash.com/photo-1616986035206-90bc396686c7?w=750&auto=format&fit=crop&q=60",
  },
  {
    id: 10,
    img: "https://images.unsplash.com/photo-1619328359755-0428244824c4?w=750&auto=format&fit=crop&q=60",
  },
  {
    id: 11,
    img: "https://images.unsplash.com/photo-1617334158858-222474874302?w=750&auto=format&fit=crop&q=60",
  },
];

/* FLEX-GALLERY */

const flex = document.querySelector(".flex-gallery");

images.forEach((item) => {
  const tag1 = document.createElement("div");
  tag1.classList.add("item");
  tag1.innerHTML = `<img src="${item.img}" alt="no_alternative">`;

  flex.appendChild(tag1);
});

/* GRID-GALLERY */

const grid = document.querySelector(".grid-gallery");

images.forEach((item) => {
  const tag2 = document.createElement("div");
  tag2.classList.add("item");
  tag2.innerHTML = `<img src="${item.img}" alt="no_alternative">`;

  grid.appendChild(tag2);
});

/* MASONRY-GALLERY */

const masonry = document.querySelector(".masonry-gallery");

images.forEach((item) => {
  const tag3 = document.createElement("div");
  tag3.classList.add("item");
  tag3.innerHTML = `<img src="${item.img}" alt="no_alternative">`;

  masonry.appendChild(tag3);
});
