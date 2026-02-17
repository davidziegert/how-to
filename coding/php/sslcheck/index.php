<?php

error_reporting(E_ALL);

function getRecord($domain)
{
  try {
    $ip = [];
    $records = dns_get_record($domain);

    foreach ($records as $record) {
      if (isset($record['ip'])) {
        $ip[] = $record['ip'];
      }
    }

    return $ip;
  } catch (Exception $e) {
    echo 'Exception(getRecord): ' . $e->getMessage();
    echo '<br><br>';
  } catch (Error $e) {
    echo 'Error(getRecord): ' . $e->getMessage();
    echo '<br><br>';
  }
}

function getCertInfo($domain)
{
  try {
    $url = "https://" . $domain;
    $orignal_parse = parse_url($url, PHP_URL_HOST);
    $port = parse_url($url, PHP_URL_PORT);

    if (!$port) {
      $port = 443;
    }

    $get = stream_context_create(array("ssl" => array("capture_peer_cert" => TRUE, 'verify_peer' => false, 'verify_peer_name' => false, 'allow_self_signed' => true)));
    $read = stream_socket_client("ssl://" . $orignal_parse . ":" . $port, $errno, $errstr, 30, STREAM_CLIENT_CONNECT, $get);
    $cert = stream_context_get_params($read);
    $cert_info = openssl_x509_parse($cert['options']['ssl']['peer_certificate'], true);

    if (empty($cert_info)) {
      return [0, 0, 0];
    } else {
      $valid_from = date('Y-m-d', $cert_info['validFrom_time_t']);
      $valid_to = date('Y-m-d', $cert_info['validTo_time_t']);

      $date1 = new DateTime('now');
      $date2 = new DateTime($valid_to);
      $diff = date_diff($date1, $date2);

      return [$valid_from, $valid_to, $diff->format('%R%a')];
    }
  } catch (Exception $e) {
    echo 'Exception(getCertInfo): ' . $e->getMessage();
    echo '<br><br>';
  } catch (Error $e) {
    echo 'Error(getCertInfo): ' . $e->getMessage();
    echo '<br><br>';
  }
}

function getColor($days)
{
  try {
    if ($days > 60) {
      return "green";
    }

    if ($days >= 30 && $days <= 60) {
      return "orange";
    }

    if ($days < 30) {
      return "red";
    }
  } catch (Exception $e) {
    echo 'Exception(getColor): ' . $e->getMessage();
    echo '<br><br>';
  } catch (Error $e) {
    echo 'Error(getColor): ' . $e->getMessage();
    echo '<br><br>';
  }
}

function makeTable()
{
  $domains = array("service.sfb1287.uni-potsdam.de", "www.sfb1287.uni-potsdam.de", "www.sfb632.uni-potsdam.de", "virtual.sfb1287.uni-potsdam.de", "chaos.sfb1287.uni-potsdam.de");
  $ips = [];
  $infos = [];

  if (count($domains) === 0) {
    echo 'ERROR: No items in the list!';
    exit();
  } else {
    echo '<table style="border-collapse: collapse; width: 100%;">';
    echo '<thead>';
    echo '<tr>';
    echo '<th>Nr.</th>';
    echo '<th>Domain</th>';
    echo '<th>IP</th>';
    echo '<th>Valid from</th>';
    echo '<th>Valid to</th>';
    echo '<th>Days left</th>';
    echo '</tr>';
    echo '</thead>';
    echo '<tbody>';

    foreach ($domains as $i => $domain) {
      $ips[] = getRecord($domain);
      $infos[] = getCertInfo($domain);

      echo '<tr>';
      echo '<td>' . ($i + 1) . '</td>';
      echo '<td>' . $domain . '</td>';
      echo '<td>' . $ips[$i][0] . '</td>';
      echo '<td>' . $infos[$i][0] . '</td>';
      echo '<td>' . $infos[$i][1] . '</td>';
      echo '<td style="color: ' . getColor(intval($infos[$i][2])) . ';">' . $infos[$i][2] . '</td>';
      echo '</tr>';
    }

    echo '</tbody>';
    echo '</table>';
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
  <title>sslcheck.tmp</title>

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
          <h1>SSL-Check</h1>
          <?php makeTable(); ?>
        </div>
      </div>
    </main>
  </div>
</body>

</html>