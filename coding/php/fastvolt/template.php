<?php

error_reporting(E_ALL);
ini_set('display_errors', 'On');

require_once __DIR__ . "/vendor/autoload.php";

$site = $_GET['site'];

use FastVolt\Helper\Markdown;

// initialize markdown object
$markdown = new Markdown(); // or Markdown::new()

// set markdown file to parse 
$markdown->setFile('./content/' . $site . '.md');

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
    <title>fastvolt.tmp</title>

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
                        <li class="menu-item"><a href="index.php">Home</a></li>

                        <?php
                        // all md files in content folder
                        $files = glob('./content/*.md');

                        foreach ($files as $file) {
                            echo '<li class="menu-item"><a href="template.php?site=' . basename($file, '.md') . '">' . basename($file, '.md') . '</a></li>';
                        }
                        ?>
                    </menu>
                </div>
            </div>
        </nav>
        <main>
            <div class="row">
                <div class="column">
                    <?php

                    // compile as raw HTML
                    echo $markdown->toHtml();

                    ?>
                </div>
            </div>
        </main>
        <footer>
            <div class="row">
                <div class="column">
                    <span>Source: <a href="https://github.com/fastvolt/markdown" target="_blank" rel="noopener noreferrer">FastVolt</a> developed by <a href="https://github.com/oladoyinbov" target="_blank" rel="noopener noreferrer">oladoyinbov</a> and <a href="https://github.com/k00ni" target="_blank" rel="noopener noreferrer">k00ni</a></span>
                </div>
            </div>
        </footer>
    </div>
</body>

</html>