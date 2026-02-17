<?php include "utilities.php" ?>

<?php

try {
    $name = $_POST["name"];
    $email = $_POST["email"];
    $password = $_POST["password"];
    $confirm_password = $_POST["confirm-password"];

    RegisterUser($name, $email, $password, $confirm_password);
} catch (Exception $e) {
    echo 'Caught exception: ', $e->getMessage(), "\n";
}

?>