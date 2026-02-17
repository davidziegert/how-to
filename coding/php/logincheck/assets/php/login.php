<?php include "utilities.php" ?>

<?php

try {
    $name = $_POST["name"];
    $password = $_POST["password"];

    LogIn($name, $password);
} catch (Exception $e) {
    echo 'Caught exception: ', $e->getMessage(), "\n";
}

?>