<?php

// for passwords only

$plain_password = 'Passw!0rd123';

$options = [
  'cost' => 12,
];

$hashed_password = '';

function BCrypt_Hash_Password()
{
  global $plain_password, $options, $hashed_password;

  // DEFAULTS FOR: 
  // password_hash($plain_password, PASSWORD_DEFAULT);

  // WITH NO OPTIONS:
  // PASSWORD_DEFAULT = PASSWORD_BCRYPT (Alternative: PASSWORD_ARGON2I)
  // cost = 10

  // ADVICE:
  // It is strongly recommended that you do not generate your own salt for this function. 
  // It will create a secure salt automatically for you if you do not specify one.

  $hashed_password = password_hash($plain_password, PASSWORD_BCRYPT, $options);

  echo "<p><strong>Password-Hash generated!</strong></p>";
  echo "<code>";
  echo "Password:";
  echo "<br>";
  echo "<br>";
  echo $plain_password;
  echo "<hr>";
  echo "Hash:";
  echo "<br>";
  echo "<br>";
  echo $hashed_password;
  echo "</code>";
}

function BCrypt_Verify_Password()
{
  global $plain_password, $hashed_password;

  if (password_verify($plain_password, $hashed_password)) {
    echo "<p><strong>Password matches with the Hash</strong></p>";
  } else {
    echo "<p><strong>Password not matches with the Hash</strong></p>";
  }
}

// for content only

$plain_content = 'Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.';

$secret_key = 'my_secret_key_123';
$secret_vector = 'my_secret_vector_123';
$encrypt_method = 'AES-256-CBC';

$encrypted_content = '';
$decrypted_content = '';

function Encrypt_Content()
{
  global $plain_content, $secret_key, $secret_vector, $encrypt_method, $encrypted_content;

  $key = hash('sha256', $secret_key);
  $vector = substr(hash('sha256', $secret_vector), 0, 16);
  $encrypted_content = openssl_encrypt($plain_content, $encrypt_method, $key, 0, $vector);
  $encrypted_content = base64_encode($encrypted_content);

  echo "<p><strong>Text encrypted!</strong></p>";
  echo "<code>";
  echo "Text:";
  echo "<br>";
  echo "<br>";
  echo $plain_content;
  echo "<hr>";
  echo "Encryption:";
  echo "<br>";
  echo "<br>";
  echo $encrypted_content;
  echo "</code>";
}

function Decrypt_Content()
{
  global $secret_key, $secret_vector, $encrypt_method, $encrypted_content, $decrypted_content;

  $key = hash('sha256', $secret_key);
  $vector = substr(hash('sha256', $secret_vector), 0, 16);
  $decrypted_content = openssl_decrypt(base64_decode($encrypted_content), $encrypt_method, $key, 0, $vector);

  echo "<p><strong>Text decrypted!</strong></p>";
  echo "<code>";
  echo "Encryption:";
  echo "<br>";
  echo "<br>";
  echo $encrypted_content;
  echo "<hr>";
  echo "Decryption:";
  echo "<br>";
  echo "<br>";
  echo $decrypted_content;
  echo "</code>";
}

function Decrypt_Verify()
{
  global $plain_content, $decrypted_content;

  if (strcmp($plain_content, $decrypted_content) == 0) {
    echo "<p><strong>Text matches with the Decryption</strong></p>";
  } else {
    echo "<p><strong>Text not matches the Decryption</strong></p>";
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
  <title>cryptography.tmp</title>

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
          <div class="box-decrypt">
            <h2>BCrypt-Password Generator</h2>
            <?php BCrypt_Hash_Password(); ?>
            <?php BCrypt_Verify_Password(); ?>
          </div>
          <div class="box-encrypt">
            <h2>OpenSSL Text Encryption</h2>
            <?php Encrypt_Content(); ?>
            <?php Decrypt_Content(); ?>
            <?php Decrypt_Verify(); ?>
          </div>
        </div>
      </div>
    </main>
  </div>
</body>

</html>