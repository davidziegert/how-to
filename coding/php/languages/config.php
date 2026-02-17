<?php

session_start();

if (!isset($_SESSION['lang'])) {
    $_SESSION['lang'] = "de";
} elseif (isset($_GET['lang']) && $_SESSION['lang'] != $_GET['lang'] && !empty($_GET['lang'])) {
    switch ($_GET['lang']) {
        case "de":
            $_SESSION['lang'] = "de";
            break;

        case "en":
            $_SESSION['lang'] = "en";
            break;

        case "fr":
            $_SESSION['lang'] = "fr";
            break;

        case "ru":
            $_SESSION['lang'] = "ru";
            break;

        default:
            $_SESSION['lang'] = "de";
    }
}

require_once $_SESSION['lang'] . ".php";
