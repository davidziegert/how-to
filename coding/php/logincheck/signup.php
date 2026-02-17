<?php include "./assets/php/utilities.php" ?>
<?php CheckLogIn(); ?>

<!doctype html>
<html lang="EN">

<head>
  <meta charset="utf-8" />
  <meta http-equiv="X-UA-Compatible" content="IE=edge" />
  <meta name="viewport" content="width=device-width, initial-scale=1" />
  <meta name="robots" content="noindex, nofollow" />
  <meta name="mobile-web-app-capable" content="yes" />
  <meta name="apple-mobile-web-app-capable" content="yes" />

  <!-- Security Token -->
  <meta name="csrf-token" content=" <?php echo CreateToken(); ?>" />

  <!-- Title Tag -->
  <title>logincheck.tmp</title>

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
          <h1>Sign Up</h1>
          <form action="./assets/php/register.php" method="POST">
            <fieldset>
              <label for="name">Name</label>
              <input type="text" id="name" name="name" placeholder="Enter your name" required />
              <label for="email">E-Mail</label>
              <input type="email" id="email" name="email" placeholder="Enter your email" required />
              <label for="password">Password</label>
              <input type="password" id="password" name="password" pattern=".{8,}" title="Eight or more characters" placeholder="Enter your password" required />
              <label for="confirm-password">Password Confirmation</label>
              <input type="password" id="confirm-password" name="confirm-password" pattern=".{8,}" title="Eight or more characters" placeholder="Confirm your password" required />
              <code>Password must include at least one upper case letter, one lower case letter, one numeric digit, one special character and a minimum length of 8.</code>
              <input type="submit" value="Sign Up" />
              <a href=" login.php">Already have an account? Log In</a>
            </fieldset>
          </form>
        </div>
      </div>
    </main>
  </div>
</body>

</html>