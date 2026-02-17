<?php

// LOAD ON EVERY PAGE

date_default_timezone_set("Europe/Berlin");
error_reporting(0);
session_set_cookie_params(["samesite" => "Strict"]);
session_start();

// SETTINGS

// base directory
$base_dir = __DIR__;

// server root folder
$document_root = $_SERVER['DOCUMENT_ROOT'];

// server protocol
$server_protocol = empty($_SERVER['HTTPS']) ? 'http' : 'https';

// server name
$server_name = $_SERVER['SERVER_NAME'];

// base url
$base_url = $server_protocol . "://" . $server_name;

// customized path
$app_folder = $base_url . "/php/login/";

// current url
$current_url = $base_url . $_SERVER['REQUEST_URI'];


function PrintSettings()
{
    global $base_dir, $server_protocol, $server_name, $document_root, $base_url, $app_folder, $current_url;

    echo "
    <table>
        <thead>
            <tr>
                <th>Name</th>
                <th>Setting</th>
            </tr>
        </thead>
        <tbody>
            <tr>
                <td>DIR</td>
                <td>$base_dir</td>
            </tr>
            <tr>
                <td>DOCUMENT_ROOT</td>
                <td>$document_root</td>
            </tr>
            <tr>
                <td>PROTOCOL</td>
                <td>$server_protocol</td>
            </tr>
            <tr>
                <td>SERVER_NAME</td>
                <td>$server_name</td>
            </tr>
            <tr>
                <td>BASE_URL</td>
                <td>$base_url</td>
            </tr>
            <tr>
                <td>BASE_FOLDER</td>
                <td>$app_folder</td>
            </tr>
            <tr>
                <td>CURRENT_URL</td>
                <td>$current_url</td>
            </tr>
        </tbody>
    </table>
    ";
}

// DATABASE

function ConnectToDB()
{
    define("HOST", "localhost");
    define("USER", "root");
    define("PASSWORD", "password");
    define("DATABASE", "db_localhost");

    try {
        $connection = new PDO("mysql:host=" . HOST . ";dbname=" . DATABASE, USER, PASSWORD);
        $connection->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
        return $connection;
    } catch (PDOException $error) {
        exit("Error: " . $error->getMessage());
    }
}

function RegisterUser($name, $email, $password, $confirm_password)
{
    global $app_folder;
    $errors = false;
    $messages = [];

    try {
        // validate username
        if (!isset($name) || strlen($name) > 255 || !preg_match("/^[a-zA-Z- ]+$/", $name)) {
            $errors = true;
            array_push($messages, "The username contains NOT allowed characters");
        }

        // remove all illegal characters from email
        $email = filter_var($email, FILTER_SANITIZE_EMAIL);

        // Validate e-mail
        if (!isset($email) || strlen($email) > 255 || !filter_var($email, FILTER_VALIDATE_EMAIL)) {
            $errors = true;
            array_push($messages, "This is NOT a valid email address");
        } else if (!checkdnsrr(substr($email, strpos($email, "@") + 1), "MX")) {
            $errors = true;
            array_push($messages, "There is NO corresponding DNS record for the email domain name");
        }

        // password must include at least one upper case letter, one lower case letter, one numeric digit, one special character and a minimum length of 8.
        if (!isset($password) || !preg_match("/^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[!@#$%^&*_=+-])(?=.{8,})/", $password)) {
            $errors = true;
            array_push($messages, "The Password does NOT meet the complexity requirements");
        } else if (!isset($confirm_password) || $confirm_password !== $password) {
            $errors = true;
            array_push($messages, "The Passwords do NOT match");
        }

        // save only hashed password in database
        $hashed_password = Hash_Password($password);

        // if no errors from above occurs, register user in db
        if ($errors == false) {
            $connection = ConnectToDB();
            $query = "INSERT INTO tb_accounts VALUES (NULL, ?, ?, ?)";

            try {
                $statement = $connection->prepare($query);
                $statement->bindParam(1, $name, PDO::PARAM_STR);
                $statement->bindParam(2, $email, PDO::PARAM_STR);
                $statement->bindParam(3, $hashed_password, PDO::PARAM_STR);
                $statement->execute();
                $statement->closeCursor();
                $statement = null;
            } catch (PDOException $error) {
                exit("Error: " . $error->getMessage());
            }

            $query = null;
            $connection = null;
        } else {
            $json = json_encode($messages);
            header("Location: " . $app_folder . "error.php?message=" . $json);
        }
    } catch (Exception $e) {
        echo "Caught exception: ", $e->getMessage(), "\n";
    }
}

function Hash_Password($password)
{
    $hashed_password = password_hash($password, PASSWORD_DEFAULT);
    return $hashed_password;
}

function PrintErrors()
{
    try {
        $json = $_GET["message"];
        $errors = json_decode($json);

        echo "<ul>";
        foreach ($errors as $error) {
            echo "<li>" . $error . "</li>";
        }
        echo "</ul>";
    } catch (Exception $e) {
        echo "Caught exception: ", $e->getMessage(), "\n";
    }
}

// LOGIN & LOGOUT

function CheckLogIn()
{
    global $app_folder, $current_url;
    $check = false;

    try {
        if (session_status() == PHP_SESSION_ACTIVE) {
            if (isset($_SESSION["LOGGEDIN"]) && $_SESSION["LOGGEDIN"] == true) {
                if (ValidateToken() == true) {
                    $check = true;
                } else {
                    $check = false;
                }
            } else {
                $check = false;
            }
        } else {
            $check = false;
        }

        // already loggedin
        if ($check == true) {
            if ($current_url == "http://localhost/php/login/login.php") {
                header("Location: " . $app_folder . "dashboard.php");
                exit();
            }
        }

        // not loggedin
        if ($check == false) {
            if ($current_url == "http://localhost/php/login/index.php" || $current_url == "http://localhost/php/login/") {
                header("Location: " . $app_folder . "login.php");
                exit();
            }

            if ($current_url == "http://localhost/php/login/dashboard.php") {
                header("Location: " . $app_folder . "login.php");
                exit();
            }
        }
    } catch (Exception $e) {
        echo "Caught exception: ", $e->getMessage(), "\n";
    }
}

function LogIn($name, $password)
{
    global $app_folder;
    $errors = false;
    $messages = [];

    try {
        $connection = ConnectToDB();
        $query = "SELECT * FROM tb_accounts WHERE _name = ?";

        try {
            $statement = $connection->prepare($query);
            $statement->bindParam(1, $name, PDO::PARAM_STR);
            $statement->execute();
            $results = $statement->fetchAll(PDO::FETCH_ASSOC);

            if (!$results) {
                $errors = true;
                array_push($messages, "No corresponding name found!");
            } else {
                foreach ($results as $row) {
                    if (password_verify($password, $row["_password"])) {
                        $_SESSION["LOGGEDIN"] = true;
                        $_SESSION["USERID"] = $row["_id"];
                        header("Location: " . $app_folder . "dashboard.php");
                        exit();
                    } else {
                        $errors = true;
                        array_push($messages, "Password not match!");
                    }
                }
            }

            $statement->closeCursor();
            $statement = null;
            $results = null;
        } catch (PDOException $error) {
            exit("Error: " . $error->getMessage());
        }

        $query = null;
        $connection = null;

        // if errors from above occurs print them
        if ($errors == true) {
            $json = json_encode($messages);
            header("Location: " . $app_folder . "error.php?message=" . $json);
        }
    } catch (Exception $e) {
        echo "Caught exception: ", $e->getMessage(), "\n";
    }
}

function LogOut()
{
    global $app_folder;

    try {
        if (isset($_COOKIE["csrf-cookie"])) {
            setcookie("csrf-cookie", "", -42000, "/");
        }

        session_unset();
        session_destroy();

        header("Location: " . $app_folder . "login.php");
        exit();
    } catch (Exception $e) {
        echo "Caught exception: ", $e->getMessage(), "\n";
    }
}

// TOKENS

function CreateToken()
{
    try {
        $session_id = session_id();
        $key = bin2hex("MY_SECRET");
        $token = hash_hmac("sha256", $session_id . "|", $key);

        setcookie("csrf-cookie", $token, 0, "/");
        return $token;
    } catch (Exception $e) {
        echo "Caught exception: ", $e->getMessage(), "\n";
    }
}

function ValidateToken()
{
    try {
        $session_id = session_id();
        $key = bin2hex("MY_SECRET");
        $token = hash_hmac("sha256", $session_id . "|", $key);

        if (isset($_COOKIE["csrf-cookie"])) {
            if (hash_equals($token, $_COOKIE["csrf-cookie"])) {
                return true;
            } else {
                return false;
            }
        } else {
            return false;
        }
    } catch (Exception $e) {
        echo "Caught exception: ", $e->getMessage(), "\n";
    }
}
