# How To - HTML - MAIN Examples

```
<!DOCTYPE html>
<html lang="en">

<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">

	<title>MAIN</title>

	<!-- FontAwesome -->
	<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

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

			display: flex;
			flex-direction: row;
			flex-wrap: nowrap;
			justify-content: center;
			align-items: center;
		}

		hr {
			border: 5px solid yellow;
		}

		#main_1 {
			background-color: white;
		}

		#main_1 #container_1 {
			display: flex;
			flex-flow: row wrap;
			width: 100%;
			text-align: center;
			gap: 8px;
		}

		#main_1 #container_1 .lightbox {
			flex: auto;
			height: 250px;
			min-width: 150px;
			border: 4px solid black;
			box-shadow: 0px 0px 8px rgba(0, 0, 0, .3);
		}

		#main_1 #container_1 .lightbox img {
			height: 250px;
			width: 100%;
			object-fit: cover;
		}

		#main_2 {
			background-color: black;
			color: white;
		}

		#main_2 #container_2 {
			overflow: hidden;
			background-color: black;
			width: 50vw;
		}

		#main_2 #container_2 .ticker {
			display: flex;
		}

		#main_2 #container_2 .item {
			flex-shrink: 0;
			width: 100%;
			box-sizing: border-box;
			padding: 10px;
			text-align: center;
		}

		@keyframes tickerh {
			0% {
				transform: translate3d(100%, 0, 0);
			}

			100% {
				transform: translate3d(-400%, 0, 0);
			}
		}

		#main_2 #container_2 .ticker {
			animation: tickerh linear 20s infinite;
		}

		#main_2 #container_2 .ticker:hover {
			animation-play-state: paused;
		}

		#main_3 #container_3 {
			width: 50vw;
		}

		#main_3 #container_3 blockquote {
			background-color: black;
			color: white;
			font-style: italic;
			border-left: 10px solid yellow;
			position: relative;
			padding: 2rem 4rem;
		}

		#main_3 #container_3 blockquote::before {
			content: open-quote;
			color: yellow;
			font-size: 4rem;
			position: absolute;
			left: 1rem;
			top: 1rem;
		}

		#main_3 #container_3 blockquote cite {
			display: block;
			color: yellow;
			font-style: normal;
			font-weight: bold;
			margin-top: 1rem;
		}

		#main_4 {
			background-color: black;
		}

		#main_4 #container_4 {
			max-width: 50vw;
			width: 100%;
		}

		#main_4 #container_4 iframe {
			width: 100%;
			height: 100%;
			aspect-ratio: 16 / 9;
		}

		#main_5 {
			background-color: white;
		}

		#main_5 #container_5 {
			display: flex;
			flex-direction: row;
			flex-wrap: wrap;
			justify-content: center;
			align-items: center;
			gap: 2rem;
		}

		#main_5 #container_5 .profile_1 {
			background-color: white;
			color: black;
			box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2);
			text-align: center;
			max-width: 300px;
		}

		#main_5 #container_5 .profile_1:hover {
			transform: scale(1.1);
		}	

		#main_5 #container_5 .profile_1 img {
			width: 100%;
		}

		#main_5 #container_5 .profile_1 h1 {
			padding: 1rem 0 0 0;
		}

		#main_5 #container_5 .profile_1 .title {
			color: grey;
			padding: 1rem 0 1rem 0;
		}

		#main_5 #container_5 .profile_1 a {
			text-decoration: none;
			color: black;
			padding: 1rem;
		}

		#main_5 #container_5 .profile_1 .button {
			border: none;
			outline: 0;
			display: inline-block;
			padding: 4%;
			color: white;
			background-color: black;
			text-align: center;
			cursor: pointer;
			width: 92%;
			margin: 1rem 0 0 0;
		}

		#main_5 #container_5 .profile_1 .button:hover {
			opacity: 0.7;
		}

		#main_5 #container_5 .profile_2 {
			background-color: white;
			color: black;
			box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2);
			text-align: center;
			max-width: 300px;
			border-radius: 8px;
		}

		#main_5 #container_5 .profile_2:hover {
			transform: scale(1.1);
		}		

		#main_5 #container_5 .profile_2 img {
			width: 65%;
			border-radius: 50%;
			margin: 1rem 0;
		}

		#main_5 #container_5 .profile_2 .title {
			color: grey;
			padding: 1rem 0 1rem 0;
		}

		#main_5 #container_5 .profile_2 a {
			text-decoration: none;
			color: black;
			padding: 1rem;
		}

		#main_5 #container_5 .profile_2 .button {
			border: none;
			outline: 0;
			display: inline-block;
			padding: 4%;
			color: black;
			text-align: center;
			cursor: pointer;
			width: 57%;
			margin: 1rem 0 1rem 0;
			border: 2px solid black;
			border-radius: 8px;
		}

		#main_5 #container_5 .profile_2 .button:hover {
			color: grey;
			border: 2px solid grey;
		}

		#main_5 #container_5 .profile_3 {
			background-color: black;
			color: white;
			box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2);
			text-align: center;
			max-width: 300px;
			border-radius: 8px;
		}

		#main_5 #container_5 .profile_3:hover {
			transform: scale(1.1);
		}		

		#main_5 #container_5 .profile_3 img {
			width: 50%;
			border-radius: 50%;
			border: 8px solid white;
			top: -75px;
			position: relative;
		}

		#main_5 #container_5 .profile_3 h1 {
			top: -50px;
			position: relative;
		}		

		#main_5 #container_5 .profile_3 .title {
			color: grey;
			top: -25px;
			position: relative;			
		}

		#main_5 #container_5 .profile_3 a {
			text-decoration: none;
			color: white;
			padding: 1rem 1rem;
		}

		#main_5 #container_5 .profile_3 .button {
			border: none;
			outline: 0;
			display: inline-block;
			padding: 4%;
			color: white;
			text-align: center;
			cursor: pointer;
			width: 57%;
			margin: 1rem 0 1rem 0;
			border: 2px solid white;
			border-radius: 8px;
		}

		#main_5 #container_5 .profile_3 .button:hover {
			color: grey;
			border: 2px solid grey;
		}
	</style>
</head>

<body>

	<section id="main_1">
		<div id="container_1">
			<a class="lightbox" href="https://picsum.photos/400" target="_blank"><img
					title="this will be displayed as a tooltip" src="https://picsum.photos/400" /></a>
			<a class="lightbox" href="https://picsum.photos/500" target="_blank"><img
					title="this will be displayed as a tooltip" src="https://picsum.photos/500" /></a>
			<a class="lightbox" href="https://picsum.photos/300" target="_blank"><img
					title="this will be displayed as a tooltip" src="https://picsum.photos/300" /></a>
			<a class="lightbox" href="https://picsum.photos/300" target="_blank"><img
					title="this will be displayed as a tooltip" src="https://picsum.photos/300" /></a>
			<a class="lightbox" href="https://picsum.photos/500" target="_blank"><img
					title="this will be displayed as a tooltip" src="https://picsum.photos/500" /></a>
			<a class="lightbox" href="https://picsum.photos/300" target="_blank"><img
					title="this will be displayed as a tooltip" src="https://picsum.photos/300" /></a>
			<a class="lightbox" href="https://picsum.photos/500" target="_blank"><img
					title="this will be displayed as a tooltip" src="https://picsum.photos/500" /></a>
			<a class="lightbox" href="https://picsum.photos/500" target="_blank"><img
					title="this will be displayed as a tooltip" src="https://picsum.photos/500" /></a>
			<a class="lightbox" href="https://picsum.photos/500" target="_blank"><img
					title="this will be displayed as a tooltip" src="https://picsum.photos/500" /></a>
			<a class="lightbox" href="https://picsum.photos/300" target="_blank"><img
					title="this will be displayed as a tooltip" src="https://picsum.photos/300" /></a>
			<a class="lightbox" href="https://picsum.photos/400" target="_blank"><img
					title="this will be displayed as a tooltip" src="https://picsum.photos/400" /></a>
			<a class="lightbox" href="https://picsum.photos/300" target="_blank"><img
					title="this will be displayed as a tooltip" src="https://picsum.photos/300" /></a>
			<a class="lightbox" href="https://picsum.photos/300" target="_blank"><img
					title="this will be displayed as a tooltip" src="https://picsum.photos/300" /></a>
			<a class="lightbox" href="https://picsum.photos/500" target="_blank"><img
					title="this will be displayed as a tooltip" src="https://picsum.photos/500" /></a>
			<a class="lightbox" href="https://picsum.photos/500" target="_blank"><img
					title="this will be displayed as a tooltip" src="https://picsum.photos/500" /></a>
			<a class="lightbox" href="https://picsum.photos/300" target="_blank"><img
					title="this will be displayed as a tooltip" src="https://picsum.photos/300" /></a>
			<a class="lightbox" href="https://picsum.photos/400" target="_blank"><img
					title="this will be displayed as a tooltip" src="https://picsum.photos/400" /></a>
			<a class="lightbox" href="https://picsum.photos/400" target="_blank"><img
					title="this will be displayed as a tooltip" src="https://picsum.photos/400" /></a>
			<a class="lightbox" href="https://picsum.photos/400" target="_blank"><img
					title="this will be displayed as a tooltip" src="https://picsum.photos/400" /></a>
		</div>
	</section>

	<hr>

	<section id="main_2">
		<div id="container_2">
			<div class="ticker">
				<div class="item">Lorem ipsum dolor sit amet, consectetur adipiscing elit.</div>
				<div class="item">Aliquam consequat varius consequat.</div>
				<div class="item">Fusce dapibus turpis vel nisi malesuada sollicitudin.</div>
				<div class="item">Pellentesque auctor molestie orci ut blandit.</div>
			</div>
		</div>
	</section>

	<hr>

	<section id="main_3">
		<div id="container_3">
			<blockquote>
				<p>Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aliquam consequat varius consequat. Fusce
					dapibus turpis vel nisi malesuada sollicitudin.</p>
				<cite>by Lore Ipsum</cite>
			</blockquote>
		</div>
	</section>

	<hr>

	<section id="main_4">
		<div id="container_4">
			<iframe src="https://www.youtube-nocookie.com/embed/B7UmUX68KtE" title="YouTube" frameborder="0"
				allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"
				allowfullscreen></iframe>
		</div>
	</section>

	<hr>

	<section id="main_5">
		<div id="container_5">
			<div class="profile_1">
				<img
					src="https://images.generated.photos/6iKuld9NDgQFqCxiLrgIxn-9kur22CgBDeham_olUSc/rs:fit:512:512/wm:0.95:sowe:18:18:0.33/czM6Ly9pY29uczgu/Z3Bob3Rvcy1wcm9k/LnBob3Rvcy92Ml8w/NzM1NjMzLmpwZw.jpg">
				<h1> Katerina Morgan</h1>
				<p class="title">CEO & Founder, O.DEX</p>
				<a href="#"><i class="fa fa-dribbble"></i></a>
				<a href="#"><i class="fa fa-linkedin"></i></a>
				<a href="#"><i class="fa fa-facebook"></i></a>
				<a class="button" href="#">Contact Me</a>
			</div>
			<div class="profile_2">
				<img
					src="https://images.generated.photos/yYwGSZ0MwO1TFxq-WuXTSChM6_DWztxa7DoAIyKQOW0/rs:fit:512:512/wm:0.95:sowe:18:18:0.33/czM6Ly9pY29uczgu/Z3Bob3Rvcy1wcm9k/LnBob3Rvcy92Ml8w/NDE0MDU2LmpwZw.jpg">
				<h1> Farai Amadu</h1>
				<p class="title">CEO & Founder, noxon</p>
				<a href="#"><i class="fa fa-dribbble"></i></a>
				<a href="#"><i class="fa fa-linkedin"></i></a>
				<a href="#"><i class="fa fa-facebook"></i></a>
				<a class="button" href="#">Contact Me</a>
			</div>
			<div class="profile_3">
				<img
					src="https://images.generated.photos/tsVwzkhBLbgvcDChqZdlwuuSfv6MD7Db-akeqQvkIBk/rs:fit:512:512/wm:0.95:sowe:18:18:0.33/czM6Ly9pY29uczgu/Z3Bob3Rvcy1wcm9k/LnBob3Rvcy92Ml8w/MzY2NDc3LmpwZw.jpg">
				<h1> Mitsuko Jiang</h1>
				<p class="title">CEO & Founder, AppTail</p>
				<a href="#"><i class="fa fa-dribbble"></i></a>
				<a href="#"><i class="fa fa-linkedin"></i></a>
				<a href="#"><i class="fa fa-facebook"></i></a>
				<a class="button" href="#">Contact Me</a>
			</div>
		</div>
	</section>

</body>

</html>
```