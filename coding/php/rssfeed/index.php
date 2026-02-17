<?php

function RssFeed()
{
  // XML
  libxml_use_internal_errors(true);
  $feed = simplexml_load_file("http://rss.dw.com/xml/rss-de-top");

  if (isset($feed) && !empty($feed)) {
    foreach ($feed->channel as $channel) {
      $title = $channel->title;
      $description = $channel->description;
      $link = $channel->link;
      $lastBuildDate = $channel->lastBuildDate;

      echo "<h2>" . $title . "</h2>";
      echo "<p><em>Last update: " . $lastBuildDate . "</em></p>";
    }

    echo "<hr>";

    echo "<div class='box-rss'>";

    foreach ($feed->channel->item as $item) {
      $title = $item->title;
      $description = $item->description;
      $link = $item->link;
      $pubDate = $item->pubDate;

      echo "<article>";
      echo "<h3><a href='" . $link . "' target='_blank'>" . $title . "</a></h3>";
      echo "<p><em>Author: Unknown | " . $pubDate . "</em></p>";
      echo "<p>" . $description . "</p>";
      echo "</article>";
    }

    echo "</div>";
  }
}

?>

<!doctype html>
<html lang="EN">

<head>
  <meta charset="utf-8" />
  <meta http-equiv="X-UA-Compatible" content="IE=edge" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <meta name="robots" content="noindex, nofollow" />
  <meta name="mobile-web-app-capable" content="yes" />
  <meta name="apple-mobile-web-app-capable" content="yes" />

  <!-- Title Tag -->
  <title>rssfeed.tmp</title>

  <!-- FavIcons -->
  <link rel="shortcut icon" type="image/x-icon" href="./assets/images/favicon.svg" />
  <link rel="apple-touch-icon" href="./assets/images/favicon.svg" />

  <!-- Styles -->
  <link rel="stylesheet" href="./assets/css/print.css" media="print" />
  <link rel="stylesheet" href="./assets/css/reset.css" media="screen" />
  <link rel="stylesheet" href="./assets/css/skeleton.css" media="screen" />
  <link rel="stylesheet" href="./assets/css/style.css" media="screen" />
  <link rel="stylesheet" href="./assets/css/theme.css" media="screen" />
</head>

<body>
  <div class="wrapper">
    <main>
      <div class="row">
        <div class="column">
          <h1>RSS-Feed</h1>
          <?php RssFeed(); ?>
        </div>
      </div>
    </main>
  </div>
</body>

</html>