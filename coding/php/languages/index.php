<?php include "config.php"; ?>

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
  <title>languages.tmp</title>

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
    <nav id="nav">
      <div class="row">
        <div class="column">
          <menu class="main-menu">
            <li class="menu-item"><a href="<?php basename(__FILE__) ?>?lang=de">DE</a></li>
            <li class="menu-item"><a href="<?php basename(__FILE__) ?>?lang=en">EN</a></li>
            <li class="menu-item"><a href="<?php basename(__FILE__) ?>?lang=fr">FR</a></li>
            <li class="menu-item"><a href="<?php basename(__FILE__) ?>?lang=ru">RU</a></li>
          </menu>
        </div>
      </div>
    </nav>
    <main>
      <div class="row">
        <div class="column">
          <h1><?php echo $lang["h1"]; ?></h1>
          <p>
            <?php echo $lang["text"]; ?>
            <?php echo ": "; ?>
            <?php echo $_SESSION["lang"]; ?>
          </p>
        </div>
      </div>
    </main>
  </div>
</body>

</html>