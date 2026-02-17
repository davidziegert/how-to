<?php

function ListDirectories()
{
  // show only subdirectories
  $dirs = array_filter(glob('*'), 'is_dir');

  echo "<ul class='box-dir'>";

  foreach ($dirs as $dir) {
    echo "<li><a href='$dir'><img src='./assets/images/folder.svg' loading='lazy' /><span>$dir</span></a></li>";
  }

  echo "</ul>";
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
  <title>ldapcheck.tmp</title>

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
          <h1>List Directories</h1>
          <?php ListDirectories(); ?>
        </div>
      </div>
    </main>
  </div>
</body>

</html>