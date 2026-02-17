function handleRSSErrors(response) {
  if (!response.ok) {
    throw Error(response.statusText);
  }
  return response;
}

function getRSSFeed(url) {
  const rss_url = url;

  //console.log(rss_url);

  fetch(rss_url)
    .then(handleRSSErrors)
    .then((response) => response.text())

    .then((str) => new window.DOMParser().parseFromString(str, "text/xml"))
    .then((data) => {
      //console.log(data);
      const container = document.getElementById("rss");
      const webtitle = data.querySelector("title");

      //console.log(webtitle.innerHTML);
      container.insertAdjacentHTML("beforeend", "<h2>" + webtitle.innerHTML + "</h2>");
      const webdescription = data.querySelector("description");

      //console.log(webdescription.innerHTML);
      container.insertAdjacentHTML("beforeend", "<em>" + webdescription.innerHTML + "</em>");
      const items = data.querySelectorAll("item");

      //console.log(items);
      let articles = "";
      items.forEach((item) => {
        articles += `
                <article>
                    <h3>${item.querySelector("title").innerHTML}</h3>
                    <p><em>${item.querySelector("pubDate").innerHTML}</em></p>
                    <p>${item.querySelector("description").innerHTML}</p>
                    <p><a href="${item.querySelector("link").innerHTML}" target="_blank" rel="noopener" title="${item.querySelector("title").innerHTML}">read more</a></p>
                </article>
            `;
      });
      container.insertAdjacentHTML("beforeend", articles);
    })
    .catch((error) => console.log(error));
}

function displayRSSFeeds() {
  const urls = ["https://rss.nytimes.com/services/xml/rss/nyt/World.xml"];
  urls.forEach((url) => {
    getRSSFeed(url);
  });
}

displayRSSFeeds();
