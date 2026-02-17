<?php

function LDAP_Check()
{
  // https://www.forumsys.com/2022/05/10/online-ldap-test-server/

  // unsecure connection
  $ldap_server = "ldap://ldap.forumsys.com";
  $ldap_port = 389;

  // secure connection
  $ldaps_server = "ldaps://ldap.forumsys.com";
  $ldaps_port = 636;

  // ldap bind user
  $ldap_user = "read-only-admin";
  $ldap_password = "password";

  // ldap bind directory
  $ldap_base_dn = "dc=example,dc=com";
  $ldap_bind_dn = "cn=$ldap_user,$ldap_base_dn";

  // ldap search base
  $ldap_search_dn = "dc=example,dc=com";
  $ldap_search_filter = "(uid=*)";
  $ldap_search_attributes = array("uid");

  // connect to ldap server
  try {
    $ldap_connection = ldap_connect($ldap_server, $ldap_port);
    ldap_set_option($ldap_connection, LDAP_OPT_PROTOCOL_VERSION, 3);
    ldap_set_option($ldap_connection, LDAP_OPT_REFERRALS, 0);

    if ($ldap_connection) {
      echo "<p>LDAP-Connection established!</p>";
    } else {
      echo "<p>LDAP-Connection failed!</p>";
    }
  } catch (Exception $e) {
    echo $e->getMessage();
    echo ldap_error($ldap_connection);
  }

  // binding to ldap server
  if ($ldap_connection) {
    try {
      $ldapbind = ldap_bind($ldap_connection, $ldap_bind_dn, $ldap_password);

      if ($ldapbind) {
        echo "<p>LDAP-Binding successful!</p>";
      } else {
        echo "<p>LDAP-Binding failed!</p>";
      }
    } catch (Exception $e) {
      echo $e->getMessage();
      echo ldap_error($ldap_connection);
    }
  }

  // search query for ldap
  if ($ldap_connection) {
    if ($ldapbind) {
      try {
        $ldap_search = ldap_search($ldap_connection, $ldap_search_dn, $ldap_search_filter);

        if ($ldap_search) {
          // get results from ldap search
          $ldap_count_entries = ldap_count_entries($ldap_connection, $ldap_search);
          $ldap_entries = ldap_get_entries($ldap_connection, $ldap_search);

          // display results, if any
          if ($ldap_count_entries > 0) {
            echo "<p>LDAP-Search results: $ldap_count_entries</p>";
            echo "<hr>";
            echo "<ul>";

            for ($i = 0; $i < $ldap_count_entries; $i++) {
              echo "<li>" . $ldap_entries[$i]["cn"][0] . " (uid: " . $ldap_entries[$i]["uid"][0] . ")</li>";
            }

            echo "</ul>";
            echo "<hr>";
          } else {
            echo "<p>No search results found!</p>";
          }
        } else {
          echo "<p>LDAP-Search failed!</p>";
        }
      } catch (Exception $e) {
        echo $e->getMessage();
        echo ldap_error($ldap_connection);
      }
    }
  }

  // close connection to ldap server
  if ($ldap_connection) {
    try {
      ldap_close($ldap_connection);
      echo "<p>LDAP-Connection closed!</p>";
    } catch (Exception $e) {
      echo $e->getMessage();
      echo ldap_error($ldap_connection);
    }
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
  <title>ldapcheck.tmp</title>

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
          <h1>LDAP-Check</h1>
          <?php LDAP_Check(); ?>
        </div>
      </div>
    </main>
  </div>
</body>

</html>