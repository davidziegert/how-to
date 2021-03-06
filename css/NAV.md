# How To - HTML - NAV Examples

```
<!DOCTYPE html>
<html lang="en">

<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">

	<title>NAV</title>

	<!-- 700+ CSS Icons-->
	<link rel="stylesheet" href="https://css.gg/all.css">

	<!-- Icons ForkAwesome-->
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/fork-awesome@1.2.0/css/fork-awesome.min.css"
		integrity="sha256-XoaMnoYC5TH6/+ihMEnospgm0J1PM/nioxbOUdnM8HY=" crossorigin="anonymous">

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

		#nav_1 #bar_1 {
			background-color: black;
			color: white;

			display: flex;
			flex-direction: column;
			flex-wrap: nowrap;
			justify-content: center;
			align-items: center;

			width: 100px;
			height: 100vh;
			text-align: center;
		}

		#nav_1 #bar_1 a {
			color: white;
			text-align: center;
			height: 100px;
			width: 100px;

			display: flex;
			justify-content: center;
			align-items: center;
		}

		#nav_1 #bar_1 a i {
			display: inline-block;
		}

		#nav_1 #bar_1 a .tooltip {
			background-color: black;
			color: yellow;
			display: inline-block;
			position: absolute;
			left: 120px;
			padding: 10px;
			visibility: hidden;
		}

		#nav_1 #bar_1 a:hover {
			background-color: black;
			color: yellow;
		}

		#nav_1 #bar_1 a:hover .tooltip {
			visibility: visible;
		}

		#nav_2 #bar_2 {
			background-color: black;
			color: white;

			display: flex;
			flex-direction: row;
			flex-wrap: nowrap;
			justify-content: center;
			align-items: center;
		}

		#nav_2 #bar_2 #menu {
			text-align: center;
			overflow: hidden;
		}

		#nav_2 #bar_2 #menu li {
			list-style: none;
			display: inline-block;
			cursor: pointer;
		}

		#nav_2 #bar_2 #menu li span {
			display: inline-block;
			padding: 1em;
			color: white;
			font-weight: bold;
		}

		#nav_2 #bar_2 #menu li a {
			display: inline-block;
			padding: 1em;
			text-decoration: none;
			color: white;
			font-weight: bold;
		}

		#nav_2 #bar_2 #menu li i {
			padding-left: 1em;
		}

		#nav_2 #bar_2 #menu li .submenu {
			position: absolute;
			background: grey;
			text-align: left;
			width: 230px;
			display: none;
		}

		#nav_2 #bar_2 #menu li .submenu li {
			display: block;
		}

		#nav_2 #bar_2 #menu li .submenu li a {
			display: block;
		}

		#nav_2 #bar_2 #menu li .submenu .fa-chevron-right {
			position: absolute;
			right: 0;
			margin-right: 1rem;
		}

		#nav_2 #bar_2 #menu li .submenu .sub_submenu {
			position: absolute;
			background: lightgrey;
			text-align: left;
			width: 230px;
			display: none;
			right: -100%;
			top: 0;
		}

		#nav_2 #bar_2 .menu li .submenu .sub_submenu li {
			display: block;
		}

		#nav_2 #bar_2 .menu li .submenu .sub_submenu li a {
			display: block;
		}

		#nav_3 #bar_3 {
			width: 500px;
			margin: auto;
		}

		#nav_3 #bar_3 #menu {
			width: 100%;
			list-style-type: none;
			border: 1px solid black;
			background-color: grey;
		}

		#nav_3 #bar_3 #menu li {
			list-style: none;
			display: block;
			cursor: pointer;
			border-bottom: 1px solid white;
		}

		#nav_3 #bar_3 #menu li:last-of-type {
			border-bottom: none;
		}

		#nav_3 #bar_3 #menu li .button {
			display: flex;
			flex-direction: row;
			flex-wrap: nowrap;
			justify-content: space-between;
			align-items: center;

			padding: 1em;
			background-color: black;
			color: white;
			font-weight: bold;
		}

		#nav_3 #bar_3 #menu li a {
			display: flex;
			flex-direction: row;
			flex-wrap: nowrap;
			justify-content: space-between;
			align-items: center;

			padding: 1em;
			background-color: black;
			color: white;
			font-weight: bold;
		}

		#nav_3 #bar_3 #menu li .submenu {
			display: none;
		}

		#nav_3 #bar_3 #menu li .submenu li {
			border-bottom: 1px solid black;
		}

		#nav_3 #bar_3 #menu li .submenu li:last-of-type {
			border-bottom: none;
		}

		#nav_3 #bar_3 #menu li .submenu li .button {
			display: flex;
			flex-direction: row;
			flex-wrap: nowrap;
			justify-content: flex-start;
			align-items: center;

			padding: 1em;
			background-color: grey;
			color: white;
			font-weight: bold;
		}

		#nav_3 #bar_3 #menu li .submenu li i {
			padding-left: 1rem;
		}

		#nav_3 #bar_3 #menu li .submenu li a {
			display: flex;
			flex-direction: row;
			flex-wrap: nowrap;
			justify-content: space-between;
			align-items: center;

			padding: 1em;
			background-color: grey;
			color: white;
			font-weight: bold;
		}

		#nav_3 #bar_3 #menu li .submenu li .sub_submenu li a {
			background-color: lightgrey;
			color: white;
			padding-left: 2rem;
		}
	</style>
</head>

<body>

	<section id="nav_1">
		<div id="bar_1">
			<a href="#">
				<i class="gg-headset"></i>
				<span class="tooltip">Headset</span>
			</a>
			<a href="#">
				<i class="gg-mic"></i>
				<span class="tooltip">Microphone</span>
			</a>
			<a href="#">
				<i class="gg-camera"></i>
				<span class="tooltip">Camera</span>
			</a>
			<a href="#">
				<i class="gg-games"></i>
				<span class="tooltip">Games</span>
			</a>
			<a href="#">
				<i class="gg-piano"></i>
				<span class="tooltip">Soundpad</span>
			</a>
		</div>
	</section>

	<hr>

	<section id="nav_2">
		<div id="bar_2">
			<ul id="menu">
				<li>
					<span class="button">Item 1<i class="fa fa-chevron-down" aria-hidden="true"></i></span>
					<ul class="submenu">
						<li>
							<span class="button">Item 1.1<i class="fa fa-chevron-right" aria-hidden="true"></i></span>
							<ul class='sub_submenu'>
								<li><a href='#'>Item 1.1.1</a></li>
								<li><a href='#'>Item 1.1.2</a></li>
								<li><a href='#'>Item 1.1.3</a></li>
							</ul>
						</li>
						<li><a href="#">Item 1.2</a></li>
						<li><a href="#">Item 1.3</a></li>
					</ul>
				</li>
				<li>
					<span class="button">Item 2<i class="fa fa-chevron-down" aria-hidden="true"></i></span>
					<ul class="submenu">
						<li><a href="#">Item 2.1</a></li>
						<li><a href="#">Item 2.2</a></li>
						<li><a href="#">Item 2.3</a></li>
					</ul>
				</li>
				<li>
					<span class="button">Item 3<i class="fa fa-chevron-down" aria-hidden="true"></i></span>
					<ul class="submenu">
						<li><a href="#">Item 3.1</a></li>
						<li><a href="#">Item 3.2</a></li>
						<li><a href="#">Item 3.3</a></li>
					</ul>
				</li>
				<li>
					<a href="#">Item 4</a>
				</li>
				<li>
					<a href="#">Item 5</a>
				</li>
			</ul>
		</div>
	</section>

	<hr>

	<section id="nav_3">
		<div id="bar_3">
			<ul id="menu">
				<li>
					<span class="button">Item 1<i class="fa fa-chevron-down" aria-hidden="true"></i></span>
					<ul class="submenu">
						<li>
							<span class="button">Item 1.1<i class="fa fa-chevron-right" aria-hidden="true"></i></span>
							<ul class='sub_submenu'>
								<li><a href='#'>Item 1.1.1</a></li>
								<li><a href='#'>Item 1.1.2</a></li>
								<li><a href='#'>Item 1.1.3</a></li>
							</ul>
						</li>
						<li><a href="#">Item 1.2</a></li>
						<li><a href="#">Item 1.3</a></li>
					</ul>
				</li>
				<li>
					<span class="button">Item 2<i class="fa fa-chevron-down" aria-hidden="true"></i></span>
					<ul class="submenu">
						<li><a href="#">Item 2.1</a></li>
						<li><a href="#">Item 2.2</a></li>
						<li><a href="#">Item 2.3</a></li>
					</ul>
				</li>
				<li>
					<span class="button">Item 3<i class="fa fa-chevron-down" aria-hidden="true"></i></span>
					<ul class="submenu">
						<li><a href="#">Item 3.1</a></li>
						<li><a href="#">Item 3.2</a></li>
						<li><a href="#">Item 3.3</a></li>
					</ul>
				</li>
				<li>
					<a href="#">Item 4</a>
				</li>
				<li>
					<a href="#">Item 5</a>
				</li>
			</ul>
		</div>
	</section>

	<script>
		$(document).ready(function () {
			$("#bar_2 #menu li").hover(
				function () {
					$(this).children('ul').slideDown('fast');
				},
				function () {
					$('ul', this).slideUp('fast');
				}
			);
		});
	</script>

	<script>
		$(document).ready(function () {
			$("#bar_3 #menu li").click(
				function () {
					if ($(this).children('.submenu').is(':visible')) {
						$(".submenu").hide('slow');
					} else {
						$(".submenu").hide('slow');
						$(this).children('ul').show('slow');
					}
				}
			);
		});
	</script>

</body>

</html>
```