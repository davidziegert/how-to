<?php

if (isset($_POST["submit"])) {

  // MAIL
  $from_email = "testme@mail.com";                                // from: system-email-address
  $recipient_email = "testme@mail.com";                           // to: recipient-email-address

  // FORM
  $sender_name = $_POST["sender_name"];                           // sender name from form
  $sender_email = $_POST["sender_email"];                         // sender email from form, it will be used in "reply-to" header
  $sender_subject = $_POST["sender_subject"];                     // sender subject for the email
  $sender_message = $_POST["sender_message"];                     // sender message for the email content

  // CONTENT
  $data = "Name: ' . $sender_name . ' \n Email: ' . $sender_email . ' \n Subject: ' . $sender_subject . ' \n Message: '' . $sender_smessage . '";

  // UPLOAD data using $_FILES array
  $tmp_name = $_FILES["sender_attachment"]["tmp_name"];           // get the temporary file name of the file on the server
  $name = $_FILES["sender_attachment"]["name"];                   // get the name of the file
  $size = $_FILES["sender_attachment"]["size"];                   // get size of the file for size validation
  $type = $_FILES["sender_attachment"]["type"];                   // get type of the file
  $error = $_FILES["sender_attachment"]["error"];                 // get the error (if any)

  //UPLOAD validatation
  if ($error > 0) {
    die('<div class="alert"><strong>Danger!</strong> Upload Error or No Files Uploaded</div>');
  }

  // UPLOAD file encoding
  $handle = fopen($tmp_name, "r");                                // set the file handle only for reading the file
  $content = fread($handle, $size);                               // reading the file
  fclose($handle);                                                // close upon completion
  $encoded_content = chunk_split(base64_encode($content));
  $boundary = md5("random");                                      // define boundary with a md5 hashed value

  // MAIL header
  $headers = "MIME-Version: 1.0\r\n";                             // defining the MIME version
  $headers .= "From:" . $from_email . "\r\n";                     // system-email-address
  $headers .= "Reply-To: " . $sender_email . "\r\n";              // email address to reach back (reply)
  $headers .= "Content-Type: multipart/mixed;";                   // defining content-type
  $headers .= "boundary = $boundary\r\n";                         // defining the boundary

  // MAIL content
  $body = "--$boundary\r\n";
  $body .= "Content-Type: text/plain; charset=ISO-8859-1\r\n";
  $body .= "Content-Transfer-Encoding: base64\r\n\r\n";
  $body .= chunk_split(base64_encode($data));

  // MAIL attachment
  $body .= "--$boundary\r\n";
  $body .= "Content-Type: $type; name=" . $name . "\r\n";
  $body .= "Content-Disposition: attachment; filename=" . $name . "\r\n";
  $body .= "Content-Transfer-Encoding: base64\r\n";
  $body .= "X-Attachment-Id: " . rand(1000, 99999) . "\r\n\r\n";
  $body .= $encoded_content;                                      // attaching the encoded file with email

  try {
    $do_send_mail = mail($recipient_email, $sender_subject, $body, $headers);

    if ($do_send_mail) {
      die('<div class="no-alert"><strong>OK!</strong> Successful Mail Delivery</div>');
    }
  } catch (Exception $e) {
    die('<div class="alert"><strong>Error: </strong> Failed Mail Delivery</div>');
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
  <title>mailform.tmp</title>

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
          <h1>Mail-Form</h1>
          <form enctype="multipart/form-data" method="POST" action="">
            <fieldset>
              <label>Name:</label>
              <input type="text" name="sender_name" placeholder="Your Name" required />
              <label>Email:</label>
              <input type="email" name="sender_email" placeholder="Your Email-Address" required />
              <label>Subject:</label>
              <input type="text" name="sender_subject" placeholder="Your Subject" />
              <label>Message:</label>
              <textarea name="sender_message" placeholder="Your Message"></textarea>
              <label>Attachment:</label>
              <input type="file" name="sender_attachment" />
              <br>
              <input type="submit" name="submit" value="Submit" />
            </fieldset>
          </form>
        </div>
      </div>
    </main>
  </div>
</body>

</html>