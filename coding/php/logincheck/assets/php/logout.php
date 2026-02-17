<?php include "utilities.php" ?>

<?php

try {
    LogOut();
} catch (Exception $e) {
    echo 'Caught exception: ', $e->getMessage(), "\n";
}

?>