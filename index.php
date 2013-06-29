<!DOCTYPE html>
<html>
<head>
	<title></title>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0"/>
	<link href='http://fonts.googleapis.com/css?family=Fauna+One' rel='stylesheet' type='text/css'>
	
	<link rel="stylesheet" type="text/css" href="/static/master-main.css">
	<script src="http://342da8a6.ngrok.com/socket.io/socket.io.js"></script>

<script type="text/javascript">
window.cityStats = "%%CITYSTATS%%";
</script>

</head>
<body>
	<section class="container">
		<header>
			<h1>Maire Académie</h1>
			<p class="lead">
				Puisque aucun maire ne peut le faire, sauvez votre ville favorite.
				<br>
				4 villes en péril, 1 numéro facile. 1-866-MAIRE29 (1-866-624-7329)
				<br>
				Pas de téléphone sous la main? Donnez un peu d'amour à votre ville en cliquant « J'aime »</p>
		</header>





		<h2>Résultats</h2>
		<ul class="clearfix resultats">
	
		</ul>
		<hr>
		
		<h2>En direct</h2>
		<ul class="livefeed" id="ticker">
			
		</ul>
		<script type="text/html" id="skeleton-vote-call">
			<li><span class="tel">514-xxx-xxxx</span>vient tout juste de voter pour<span class="city">Hérouxville</span></li>
		</script>
		<script type="text/html" id="skeleton-vote-like">
			<li>Un vote de plus pour <span class="city">Hérouxville</span></li>
		</script>

		<script type="text/html" id="skeleton-city">
			<li class="col col-lg-3 city" data-city-id="">
				<article>
					<b>Vote pour <span class="city-name">Montreal</span></b>
					<span class="vote-count hide">0</span>

					<aside>
						Stuff pour FB LIKE
						<a href="">Like ta ville</a>
					</aside>
				</article>
			</li>
		</script>
	</section>
	<script src="//ajax.googleapis.com/ajax/libs/jquery/1.10.1/jquery.min.js"></script>
	<script src="./static/local/coffee/app.js"></script>
</body>
</html>