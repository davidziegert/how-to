function loadXMLDoc() {
  let xmlhttp = new XMLHttpRequest();
  xmlhttp.onreadystatechange = function () {
    if (this.readyState == 4 && this.status == 200) {
      loadXMLData(this);
    }
  };
  xmlhttp.open("GET", "./assets/data/blog.xml", true);
  xmlhttp.send();
}

function loadXMLData(xml) {
  let i;
  let xmlDoc = xml.responseXML;
  let x = xmlDoc.getElementsByTagName("POST");
  let items = "";

  for (i = 1; i < x.length; i++) {
    items +=
      "<article class='blog-post'><div class='blog-author'><strong>" +
      x[i].getElementsByTagName("AUTHOR")[0].childNodes[0].nodeValue +
      "</strong></div><div class='blog-published'><small>" +
      x[i].getElementsByTagName("PUBLISHED")[0].childNodes[0].nodeValue +
      "</small></div><div class='blog-title'><em>" +
      x[i].getElementsByTagName("TITLE")[0].childNodes[0].nodeValue +
      "</em></div><div class='blog-content'>" +
      x[i].getElementsByTagName("CONTENT")[0].childNodes[0].nodeValue +
      "</div><div class='blog-link'><a href='" +
      x[i].getElementsByTagName("LINK")[0].childNodes[0].nodeValue +
      "' target='_blank'>read more</a></div></article>";
  }

  document.getElementById("xml").innerHTML = items;
}

loadXMLDoc();
