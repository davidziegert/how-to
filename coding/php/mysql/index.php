<?php
function ConnectToDB()
{
  define('DB_HOST', '127.0.0.1');     // Database host (use 'localhost' or IP)
  define('DB_NAME', 'db_test');       // Database name
  define('DB_USER', 'sammy');         // Database username
  define('DB_PASS', 'password');      // Database password
  define('DB_CHARSET', 'utf8mb4');    // Character set

  $dsn = 'mysql:host=' . DB_HOST . ';dbname=' . DB_NAME . ';charset=' . DB_CHARSET;

  $options = [
    PDO::ATTR_ERRMODE            => PDO::ERRMODE_EXCEPTION,     // Throw exceptions on errors
    PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC,           // Fetch associative arrays
    PDO::ATTR_EMULATE_PREPARES   => false,                      // Use real prepared statements
  ];

  try {
    // Create PDO instance
    $pdo = new PDO($dsn, DB_USER, DB_PASS, $options);
    return $pdo;
  } catch (PDOException $e) {
    // Handle connection error
    echo '<p style="color:red;">Connection failed: ' . $e->getMessage() . '</p>';
  }
}

function SelectFromDB()
{
  // Connect to database
  $connection = ConnectToDB();

  try {
    // Prepare query with placeholders
    $sql = 'SELECT * FROM tb_users';
    $query = $connection->prepare($sql);

    // Bind parameters and execute
    $query->execute([]);

    // Fetch results
    $results = $query->fetchAll();

    if ($results) {

      echo '<table>';
      echo '<thead>';
      echo '<tr>';
      echo '<th>ID</th>';
      echo '<th>USERNAME</th>';
      echo '<th>EMAIL</th>';
      echo '<th>DEPARTMENT</th>';
      echo '</tr>';
      echo '</thead>';
      echo '<tbody>';

      foreach ($results as $row) {
        echo '<tr>';
        echo '<td>' . $row['_id'] . '</td>';
        echo '<td>' . $row['_username'] . '</td>';
        echo '<td>' . $row['_email'] . '</td>';
        echo '<td>' . $row['_department'] . '</td>';
        echo '</tr>';
      }

      echo '</tbody>';
      echo '</table>';
    }

    $query->closeCursor();
    $query = null;
    $results = null;
  } catch (PDOException $e) {
    echo '<p style="color:red;">Query failed: ' . $e->getMessage() . '</p>';
  }
}

function InsertIntoDB($username, $email, $department)
{
  // Connect to database
  $connection = ConnectToDB();

  try {
    // Prepare query with placeholders
    $sql = 'INSERT INTO tb_users (_username, _email, _department) VALUES (:username, :email, :department)';
    $query = $connection->prepare($sql);

    // Bind parameters and execute
    $query->execute([
      ':username'     => $username,
      ':email'        => $email,
      ':department'   => $department
    ]);

    $query->closeCursor();
    $query = null;
  } catch (PDOException $e) {
    echo '<p style="color:red;">Query failed: ' . $e->getMessage() . '</p>';
  }
}

function UpdateDB($username, $department)
{
  // Connect to database
  $connection = ConnectToDB();

  try {
    // Prepare query with placeholders
    $sql = 'UPDATE tb_users SET _department = :department WHERE _username = :username';
    $query = $connection->prepare($sql);

    // Bind parameters and execute
    $query->execute([
      ':username'     => $username,
      ':department'   => $department
    ]);

    $query->closeCursor();
    $query = null;
  } catch (PDOException $e) {
    echo '<p style="color:red;">Query failed: ' . $e->getMessage() . '</p>';
  }
}

function DeleteFromDB($username)
{
  // Connect to database
  $connection = ConnectToDB();

  try {
    // Prepare query with placeholders
    $sql = 'DELETE FROM tb_users WHERE _username = :username';
    $query = $connection->prepare($sql);

    // Bind parameters and execute
    $query->execute([
      ':username'   => $username
    ]);

    $query->closeCursor();
    $query = null;
  } catch (PDOException $e) {
    echo '<p style="color:red;">Query failed: ' . $e->getMessage() . '</p>';
  }
}

function TruncateDB()
{
  // Connect to database
  $connection = ConnectToDB();

  try {
    // Prepare query with placeholders
    $sql = 'TRUNCATE TABLE tb_users';
    $query = $connection->prepare($sql);

    // Bind parameters and execute
    $query->execute([]);

    $query->closeCursor();
    $query = null;
  } catch (PDOException $e) {
    echo '<p style="color:red;">Query failed: ' . $e->getMessage() . '</p>';
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
  <title>mysql.tmp</title>

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
          <h1>MySQL-Test</h1>

          <?php TruncateDB(); ?>

          <?php InsertIntoDB("john.doe", "john.doe@example.com", "Engineering"); ?>
          <?php InsertIntoDB("jane.smith", "jane.smith@example.com", "Marketing"); ?>
          <?php InsertIntoDB("peter.jones", "peter.jones@example.com", "Sales"); ?>
          <?php InsertIntoDB("sarah.williams", "sarah.williams@example.com", "Human Resources"); ?>

          <?php SelectFromDB(); ?>

          <?php UpdateDB("john.doe", "CEO"); ?>
          <?php DeleteFromDB("sarah.williams"); ?>

          <hr>

          <?php SelectFromDB(); ?>
        </div>
      </div>
    </main>
  </div>
</body>

</html>