# How To - HTML - HEADER Examples

```
<!DOCTYPE html>
<html lang="en">

<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">

	<title>HEADER</title>

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
			height: 100vh;
			width: 100vw;
		}

		hr {
			border: 5px solid yellow;
		}

		#header_1 {
			background-image: url("https://picsum.photos/1920");
			background-position: center;
			background-repeat: no-repeat;
			background-size: cover;

			display: flex;
			flex-direction: column;
			flex-wrap: nowrap;
			justify-content: center;
			align-items: center;
		}

		#header_1 h1 {
			width: 50vw;
			text-align: center;
			background-color: black;
			color: white;
			padding: 1rem;
		}

		#header_2 #header2_img {
			height: 50vh;
			width: 100vw;

			background-image: url("https://picsum.photos/1921");
			background-position: center;
			background-repeat: no-repeat;
			background-size: cover;

			display: flex;
			flex-direction: column;
			flex-wrap: nowrap;
			justify-content: center;
			align-items: center;
		}

		#header_2 #header2_img h1 {
			width: 50vw;
			text-align: center;
			background-color: black;
			color: white;
			padding: 1rem;
		}

		#header_2 #header2_text {
			height: 50vh;
			width: 100vw;

			display: flex;
			flex-direction: column;
			flex-wrap: nowrap;
			justify-content: center;
			align-items: center;

			text-align: center;
		}

		#header_3 {
			display: flex;
			flex-direction: column;
			flex-wrap: nowrap;
			justify-content: center;
			align-items: center;
		}

		#header_3 video {
			object-fit: cover;
			width: 100vw;
			height: 100vh;

			z-index: 1;
			position: absolute;
		}

		#header_3 h1 {
			z-index: 2;
			position: relative;

			width: 50vw;
			text-align: center;
			background-color: black;
			color: white;
			padding: 1rem;
		}

		#header_4 #container {
			width: 100vw;
			height: 100vh;

			position: absolute;
		}

		#header_4 #container .frame {
			width: 100vw;
			height: 100vh;

			display: flex;
			flex-direction: column;
			flex-wrap: nowrap;
			justify-content: center;
			align-items: center;

			display: none;
		}

		#header_4 #container .frame img {
			width: 100vw;
			height: 100vh;
			object-fit: cover;

			z-index: 1;
			position: absolute;
		}

		#header_4 #container .frame .caption {
			width: 33.333vw;
			text-align: center;
			background-color: black;
			color: white;
			padding: 1rem;

			z-index: 2;
			position: relative;
		}

		#header_4 #container #btn_prev {
			z-index: 3;
			position: absolute;

			height: 4vh;
			width: auto;
			top: 48vh;
			left: 0;

			display: flex;
			justify-content: center;
			align-items: center;
		}

		#header_4 #container #btn_next {
			z-index: 3;
			position: absolute;

			height: 4vh;
			width: auto;
			top: 48vh;
			right: 0;

			display: flex;
			justify-content: center;
			align-items: center;
		}

		#header_4 #container #btn_prev .prev,
		#header_4 #container #btn_next .next {
			cursor: pointer;
			user-select: none;
			text-decoration: none;

			font-weight: bold;
			padding: 1rem;

			background-color: black;
			color: white;
		}

		#header_5 #wrapper {
			width: 100vw;
			height: 100vh;

			position: absolute;
		}

		#header_5 #wrapper .slider {
			width: 100vw;
			height: 100vh;

			display: flex;
			flex-direction: column;
			flex-wrap: nowrap;
			justify-content: center;
			align-items: center;

			display: none;
		}

		#header_5 #wrapper .slider img {
			width: 100vw;
			height: 100vh;
			object-fit: cover;

			z-index: 1;
			position: absolute;
		}

		#header_5 #wrapper .slider .caption {
			width: 33.333vw;
			text-align: center;
			background-color: black;
			color: white;
			padding: 1rem;

			z-index: 2;
			position: relative;
		}
	</style>
</head>

<body>

	<section id="header_1">
		<h1>Fullscreen Background Image</h1>
	</section>

	<hr>

	<section id="header_2">
		<div id="header2_img">
			<h1>Halfscreen Background Image</h1>
		</div>
		<div id="header2_text">
			<p>Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut labore
				et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea
				rebum. Stet clita kasd gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.</p>
		</div>
	</section>

	<hr>

	<section id="header_3">
		<video autoplay muted loop>
			<source src="https://www.w3schools.com/howto/rain.mp4" type="video/mp4">
			Your browser does not support HTML5 video.
		</video>
		<h1>Fullscreen Background Video</h1>
	</section>

	<hr>

	<section id="header_4">
		<div id="container">
			<div class="frame">
				<img src="https://picsum.photos/1922">
				<div class="caption">Fullscreen Background Manual Image Slider: 1 of 3</div>
			</div>
			<div class="frame">
				<img src="https://picsum.photos/1923">
				<div class="caption">Fullscreen Background Manual Image Slider: 2 of 3</div>
			</div>
			<div class="frame">
				<img src="https://picsum.photos/1924">
				<div class="caption">Fullscreen Background Manual Image Slider: 3 of 3</div>
			</div>

			<div id="btn_prev">
				<a class="prev" onclick="nextImage(-1)">&#10094;</a>
			</div>
			<div id="btn_next">
				<a class="next" onclick="nextImage(1)">&#10095;</a>
			</div>
		</div>
	</section>

	<hr>

	<section id="header_5">
		<div id="wrapper">
			<div class="slider">
				<img src="https://picsum.photos/1925">
				<div class="caption">Fullscreen Background Auto Image Slider: 1 of 3</div>
			</div>
			<div class="slider">
				<img src="https://picsum.photos/1926">
				<div class="caption">Fullscreen Background Auto Image Slider: 2 of 3</div>
			</div>
			<div class="slider">
				<img src="https://picsum.photos/1927">
				<div class="caption">Fullscreen Background Auto Image Slider: 3 of 3</div>
			</div>
		</div>
	</section>

	<script>
		let myIndex = 1;

		showImage(myIndex);

		function currentImage(n) {
			showImage(myIndex = n);
		}

		function nextImage(n) {
			showImage(myIndex += n);
		}

		function showImage(n) {
			let i;
			let myImages = document.getElementsByClassName("frame");

			if (n > myImages.length) {
				myIndex = 1
			}
			if (n < 1) {
				myIndex = myImages.length
			}

			for (i = 0; i < myImages.length; i++) {
				myImages[i].style.display = "none";
			}

			myImages[myIndex - 1].style.display = "flex";
		}
	</script>

	<script>
		let slideIndex = 0;

		showSlides();

		function showSlides() {
			let i;
			let mySlides = document.getElementsByClassName("slider");

			for (i = 0; i < mySlides.length; i++) {
				mySlides[i].style.display = "none";
			}
			slideIndex++;
			if (slideIndex > mySlides.length) {
				slideIndex = 1
			}

			mySlides[slideIndex - 1].style.display = "flex";

			setTimeout(showSlides, 2000);
		}
	</script>

</body>

</html>
```