# How To - HTML - FOOTER Examples

```
<!DOCTYPE html>
<html lang="en">

<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">

	<title>FOOTER</title>

	<!-- Academicons -->
	<link rel="stylesheet" href="https://cdn.jsdelivr.net/gh/jpswalsh/academicons@1/css/academicons.min.css">

	<!-- Styles -->
	<style>
		* {
			padding: 0;
			margin: 0;
			outline: none;
		}

		section {
			min-height: 50vh;
			width: 100vw;
		}

		hr {
			border: 5px solid yellow;
		}

		#footer_1 {
			background-color: white;
			color: black;
			display: flex;
			flex-direction: row;
			flex-wrap: nowrap;
			justify-content: center;
			align-items: center;
		}

		#footer_1 #container_1 {
			display: grid;
			grid-template-columns: auto auto;
			grid-template-rows: 1fr;
			gap: 2rem;
			width: 75vw;
		}

		#footer_1 #wrapper_1 {
			border-right: 2px solid black;
			padding: 1rem 0rem 1rem 1rem;
		}

		#footer_1 #wrapper_2 {
			display: flex;
			flex-direction: row;
			flex-wrap: wrap;
			justify-content: flex-start;
			align-items: flex-start;

			gap: 2rem 4rem;
			padding: 1rem;
		}

		#footer_1 #wrapper_1 .sitemap .tree,
		#footer_1 #wrapper_1 .sitemap .tree ul {
			margin: 0 0 0 1em;
			padding: 0;
			list-style: none;
			position: relative;
		}

		#footer_1 #wrapper_1 .sitemap .tree ul {
			margin-left: .5em
		}

		#footer_1 #wrapper_1 .sitemap .tree:before,
		#footer_1 #wrapper_1 .sitemap .tree ul:before {
			content: "";
			display: block;
			width: 0;
			position: absolute;
			top: 0;
			bottom: 0;
			left: 0;
			border-left: 1px solid;
		}

		#footer_1 #wrapper_1 .sitemap .tree li {
			margin: 0;
			padding: 0 1.5em;
			line-height: 1.5em;
			position: relative;
		}

		#footer_1 #wrapper_1 .sitemap .tree li:before {
			content: "";
			display: block;
			width: 10px;
			height: 0;
			border-top: 1px solid;
			margin-top: -1px;
			position: absolute;
			top: 1em;
			left: 0;
		}

		#footer_1 #wrapper_1 .sitemap .tree li:last-child:before {
			background: white;
			/* same with body background */
			height: auto;
			top: 1em;
			bottom: 0;
		}

		#footer_1 #wrapper_1 a,
		#footer_1 #wrapper_2 a {
			color: grey;
			text-decoration: none;
		}

		#footer_1 #wrapper_1 a:hover,
		#footer_1 #wrapper_2 a:hover {
			color: red;
		}

		#footer_1 #wrapper_2 .categories ol {
			list-style-position: inside;
		}

		#footer_1 #wrapper_2 .links ul {
			list-style-position: inside;
		}

		#footer_1 #wrapper_2 .sitemap ul {
			list-style-type: none;
		}

		#footer_2 {
			background-color: black;
			color: white;
			display: flex;
			flex-direction: row;
			flex-wrap: nowrap;
			justify-content: center;
			align-items: center;
		}

		#footer_2 #wrapper_3 {
			display: flex;
			flex-direction: row;
			flex-wrap: wrap;
			justify-content: flex-start;
			align-items: flex-start;
			gap: 2rem 4rem;
			padding: 2rem;
		}

		#footer_2 #wrapper_3 a {
			color: lightgrey;
			display: inline-block;
			text-decoration: none;
		}

		#footer_2 #wrapper_3 a::after {
			content: "\0020 ·";
		}

		#footer_2 #wrapper_3 a:last-of-type::after {
			content: "";
		}

		#footer_2 #wrapper_3 a:hover {
			color: yellow;
		}

		#footer_3 {
			background-color: black;
			color: white;
			display: flex;
			flex-direction: row;
			flex-wrap: nowrap;
			justify-content: center;
			align-items: center;
		}

		#footer_3 #container_3 {
			display: grid;
			grid-template-columns: 1fr;
			grid-template-rows: 1fr 1fr;
			gap: 0;
		}

		#footer_3 #wrapper_4 {
			display: flex;
			flex-direction: row;
			flex-wrap: wrap;
			justify-content: flex-start;
			align-items: flex-start;
			gap: 2rem 4rem;
			padding: 2rem;
		}

		#footer_3 #wrapper_5 {
			display: flex;
			flex-direction: row;
			flex-wrap: nowrap;
			justify-content: space-between;
			align-items: flex-start;
			gap: 2rem 4rem;
			padding: 2rem;
			border-top: 1px solid lightgrey;
		}

		#footer_3 #wrapper_4 li,
		#footer_3 #wrapper_5 li {
			list-style-type: none;
		}

		#footer_3 #wrapper_4 li,
		#footer_3 #wrapper_5 li,
		#footer_3 #wrapper_4 p,
		#footer_3 #wrapper_5 p,
		#footer_3 #wrapper_4 a,
		#footer_3 #wrapper_5 a {
			color: lightgrey;
			text-decoration: none;
		}

		#footer_3 #wrapper_4 a:hover,
		#footer_3 #wrapper_5 a:hover {
			color: yellow;
		}
	</style>
</head>

<body>
	<section id="footer_1">
		<div id="container_1">
			<div id="wrapper_1">
				<div class="box sitemap">
					<h1>Sitemap</h1>
					<ul class="tree">
						<li><a href="#">Categorie_1</a>
							<ul>
								<li><a href="#">Point_1.1</a></li>
								<li><a href="#">Sub-Categorie_1.1</a>
									<ul>
										<li><a href="#">Point_1.1.1</a></li>
										<li><a href="#">Point_1.1.2</a></li>
									</ul>
								</li>
								<li><a href="#">Point_1.2</a></li>
							</ul>
						</li>
						<li><a href="#">Categorie_2</a>
							<ul>
								<li><a href="#">Point_2.1</a></li>
								<li><a href="#">Sub-Categorie_2.2</a>
									<ul>
										<li><a href="#">Point_2.2.1</a></li>
										<li><a href="#">Point_2.2.2</a></li>
									</ul>
								</li>
								<li><a href="#">Point_2.2</a></li>
							</ul>
						</li>
					</ul>
				</div>
			</div>
			<div id="wrapper_2">
				<div class="box categories">
					<h1>Some Categories</h1>
					<ol>
						<li><a href="#">Categorie 1</a></li>
						<li><a href="#">Categorie 2</a></li>
						<li><a href="#">Categorie 3</a></li>
						<li><a href="#">Categorie 4</a></li>
						<li><a href="#">Categorie 5</a></li>
					</ol>
				</div>
				<div class="box links">
					<h1>Some Quick Links</h1>
					<ul>
						<li><a href="#">Link 1</a></li>
						<li><a href="#">Link 2</a></li>
						<li><a href="#">Link 3</a></li>
						<li><a href="#">Link 4</a></li>
						<li><a href="#">Link 5</a></li>
					</ul>
				</div>
				<div class="box icons">
					<h1>Icons</h1>
					<a href="#"><i class="ai ai-moodle-square ai-2x"></i></a>
					<a href="#"><i class="ai ai-google-scholar-square ai-2x"></i></a>
					<a href="#"><i class="ai ai-protocols-square ai-2x"></i></a>
					<a href="#"><i class="ai ai-sci-hub-square ai-2x"></i></a>
					<a href="#"><i class="ai ai-researchgate-square ai-2x"></i></a>
				</div>
				<div class="box about">
					<h1>About</h1>
					<p>Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt
						ut labore et dolore magna aliquyam erat, sed diam voluptua.</p>
					<p>At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea
						takimata sanctus est Lorem ipsum dolor sit amet.</p>
				</div>
				<div class="box logos">
					<h1>Logos</h1>
					<img title="this will be displayed as a tooltip" src="https://picsum.photos/200/100" />
					<img title="this will be displayed as a tooltip" src="https://picsum.photos/200/100" />
				</div>
			</div>
		</div>
	</section>

	<hr>

	<section id="footer_2">
		<div id="wrapper_3">
			<div class="box categories">
				<h1>Some Categories</h1>
				<a href="#">Categorie 1</a>
				<a href="#">Categorie 2</a>
				<a href="#">Categorie 3</a>
				<a href="#">Categorie 4</a>
				<a href="#">Categorie 5</a>
			</div>
			<div class="box links">
				<h1>Some Quick Links</h1>
				<a href="#">Link 1</a>
				<a href="#">Link 2</a>
				<a href="#">Link 3</a>
				<a href="#">Link 4</a>
				<a href="#">Link 5</a>
			</div>
			<div class="box icons">
				<h1>Icons</h1>
				<a href="#"><i class="ai ai-moodle-square ai-2x"></i></a>
				<a href="#"><i class="ai ai-google-scholar-square ai-2x"></i></a>
				<a href="#"><i class="ai ai-protocols-square ai-2x"></i></a>
				<a href="#"><i class="ai ai-sci-hub-square ai-2x"></i></a>
				<a href="#"><i class="ai ai-researchgate-square ai-2x"></i></a>
			</div>
		</div>
	</section>

	<hr>

	<section id="footer_3">
		<div id="container_3">
			<div id="wrapper_4">
				<div class="box logos">
					<h1>Logos</h1>
					<img title="this will be displayed as a tooltip" src="https://picsum.photos/200/100" />
					<img title="this will be displayed as a tooltip" src="https://picsum.photos/200/100" />
				</div>
				<div class="box categories">
					<h1>Some Categories</h1>
					<ul>
						<li><a href="#">Categorie 1</a></li>
						<li><a href="#">Categorie 2</a></li>
						<li><a href="#">Categorie 3</a></li>
						<li><a href="#">Categorie 4</a></li>
						<li><a href="#">Categorie 5</a></li>
					</ul>
				</div>
				<div class="box links">
					<h1>Some Quick Links</h1>
					<ul>
						<li><a href="#">Link 1</a></li>
						<li><a href="#">Link 2</a></li>
						<li><a href="#">Link 3</a></li>
						<li><a href="#">Link 4</a></li>
						<li><a href="#">Link 5</a></li>
					</ul>
				</div>
			</div>
			<div id="wrapper_5">
				<div class="box about">
					<h1>About</h1>
					<p>Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt
						ut labore et dolore magna aliquyam erat, sed diam voluptua.</p>
					<p>At vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no sea
						takimata sanctus est Lorem ipsum dolor sit amet.</p>
				</div>
				<div class="box icons">
					<h1>Icons</h1>
					<a href="#"><i class="ai ai-moodle-square ai-2x"></i></a>
					<a href="#"><i class="ai ai-google-scholar-square ai-2x"></i></a>
					<a href="#"><i class="ai ai-protocols-square ai-2x"></i></a>
					<a href="#"><i class="ai ai-sci-hub-square ai-2x"></i></a>
					<a href="#"><i class="ai ai-researchgate-square ai-2x"></i></a>
				</div>
			</div>
		</div>
	</section>
</body>

</html>
```