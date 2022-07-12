# How To - HTML - ASIDE Examples

```
<!DOCTYPE html>
<html lang="en">

<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">

	<title>ASIDE</title>

	<!-- jQuery -->
	<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

	<!-- Styles -->
	<style>
		* {
			padding: 0;
			margin: 0;
			outline: none;
		}

		section {
			min-height: 100vh;
			width: 100vw;
		}

		hr {
			border: 5px solid yellow;
		}

		#aside_1 {
			background-color: black;
			color: white;
			display: flex;
			flex-direction: row;
			flex-wrap: nowrap;
			justify-content: center;
			align-items: center;
		}

		#aside_1 #wrapper {
			width: 80vw;
			max-width: 1200px;
			text-align: center;
		}

		#aside_1 #wrapper a {
			color: yellow;
		}

		#aside_1 #wrapper iframe {
			width: 100%;
			height: 100%;
			aspect-ratio: 16 / 9;
		}

		@media (min-width: 0px) and (max-width: 1000px) {
			#aside_1 #wrapper {
				display: grid;
				grid-template-rows: 1fr 1fr;
				gap: 2rem;
			}
		}

		@media (min-width: 1001px) {
			#aside_1 #wrapper {
				display: grid;
				grid-template-columns: 1fr 2fr;
				gap: 2rem;
			}
		}

		#aside_2 {
			background-color: black;
			color: white;
			display: flex;
			flex-direction: row;
			flex-wrap: nowrap;
			justify-content: center;
			align-items: center;
		}

		#aside_2 #wrapper {
			width: 80vw;
			max-width: 1500px;

			display: flex;
			flex-direction: row;
			flex-wrap: wrap;
			justify-content: center;
			align-items: center;
			gap: 2rem;
		}

		#aside_2 #wrapper .card_1 {
			background-image: url("https://picsum.photos/299");
			background-position: center;
			background-repeat: no-repeat;
			background-size: cover;

			width: 100%;
			height: 100%;
			aspect-ratio: 16 / 9;
			max-width: 500px;

			display: flex;
			flex-direction: row;
			flex-wrap: nowrap;
			justify-content: flex-start;
			align-items: center;
		}

		#aside_2 #wrapper .card_1_text {
			background-color: white;
			color: black;
			padding: 1rem;

			width: 50%;
		}

		#aside_2 #wrapper .card_2 {
			width: 100%;
			height: 100%;
			aspect-ratio: 16 / 9;
			max-width: 500px;

			display: grid;
			grid-template-columns: 50% 50%;
		}

		#aside_2 #wrapper .card_2_img {
			width: 100%;
			height: 100%;
			object-fit: cover;
		}

		#aside_2 #wrapper .card_2_text {
			background-color: white;
			color: black;
			padding: 1rem;
		}

		#aside_2 #wrapper .card_3 {
			width: 100%;
			height: 100%;
			aspect-ratio: 9 / 16;
			max-width: 250px;

			display: grid;
			grid-template-rows: 50% 50%;
		}

		#aside_2 #wrapper .card_3_img {
			width: 100%;
			height: 100%;
			object-fit: cover;
		}

		#aside_2 #wrapper .card_3_text {
			background-color: white;
			color: black;
			padding: 1rem;
		}

		#aside_3 {
			background-color: black;
			color: white;
			display: flex;
			flex-direction: row;
			flex-wrap: nowrap;
			justify-content: center;
			align-items: center;
		}

		#aside_3 #wrapper {
			width: 80vw;
			max-width: 1200px;
		}

		#aside_3 form {
			display: flex;
			flex-direction: column;
			flex-wrap: nowrap;
			justify-content: center;
			align-items: center;
			background-color: white;
			color: black;
			padding: 2vw;
		}

		#aside_3 form label,
		#aside_3 form input,
		#aside_3 form textarea {
			display: block;
			resize: none;
			padding: 1%;
			width: 98%;
		}

		#aside_3 form input[type=submit] {
			width: 50%;
			margin-top: 2rem;
		}
	</style>
</head>

<body>

	<section id="aside_1">
		<div id="wrapper">
			<address>
				<h1>SampleCompany</h1>
				<br>
				<p>E-Mail: <a href="mailto:info@example.org">info@example.org</a></p>
				<p>Web-Site: <a href="https://wwww.example.org">www.example.org</a></p>
				<p>---</p>
				<p>SampleCompany</p>
				<p>2880 Broadway, New York</p>
				<p>NY 10025, USA</p>
			</address>
			<iframe
				src="https://maps.google.com/maps?q=2880%20Broadway,%20New%20York&t=&z=13&ie=UTF8&iwloc=&output=embed"
				frameborder="0" scrolling="no" marginheight="0" marginwidth="0">
			</iframe>
		</div>
	</section>

	<hr>

	<section id="aside_2">
		<div id="wrapper">
			<div class="card_1">
				<div class="card_1_text">
					<h3>Header</h3>
					<p>Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt
						ut labore et dolore magna aliquyam erat, sed diam voluptua.</p>
					<a href="https://wwww.example.org">read more</a>
				</div>
			</div>
			<div class="card_2">
				<img class="card_2_img" src="https://picsum.photos/500">
				<div class="card_2_text">
					<h3>Header</h3>
					<p>Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt
						ut labore et dolore magna aliquyam erat, sed diam voluptua.</p>
					<a href="https://wwww.example.org">read more</a>
				</div>
			</div>
			<div class="card_3">
				<img class="card_3_img" src="https://picsum.photos/301">
				<div class="card_3_text">
					<h3>Header</h3>
					<p>Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt
						ut labore et dolore magna aliquyam erat, sed diam voluptua.</p>
					<a href="https://wwww.example.org">read more</a>
				</div>
			</div>
		</div>
	</section>

	<hr>

	<section id="aside_3">
		<div id="wrapper">
			<form method='POST' action='#' accept-charset='UTF-8'>
				<label for="name">Name</label>
				<input type="text" id="name" name="name">
				<label for="email">E-Mail:</label>
				<input type="email" id="email" name="email">
				<label for="message">Message</label>
				<textarea id="message" name="message" rows="5"></textarea>
				<input type="submit" value="Submit">
			</form>
		</div>
	</section>

</body>

</html>
```