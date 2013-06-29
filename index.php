<!DOCTYPE html>
<html>
<head>
	<title>Maire Académie - Qui sauverez-vous ?</title>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=0"/>

	<meta property="og:image" content="http://www.maireacademie.ca/static/img/logo.png"/>
	<meta property="og:title" content="Maire Académie"/>
	<meta property="og:description" content="Prenez les choses en main et appelez au 1-866-MAIRE29 pour sauver votre ville." /> 



	<link href='http://fonts.googleapis.com/css?family=Fauna+One' rel='stylesheet' type='text/css'>

	<link rel="stylesheet" type="text/css" href="/static/master-main.css">
	<script src="http://342da8a6.ngrok.com/socket.io/socket.io.js"></script>

<script type="text/javascript">
window.cityStats = "%%CITYSTATS%%";
</script>

</head>
<body>
	<div id="fb-root"></div>
	<section class="container">
		<header class="a-center">
			<h1>Maire Académie</h1>
			<div class="well">
				<p class="lead">
					Puisque aucun maire ne peut le faire, sauvez votre ville favorite.
					<br>-<br>
					4 villes en péril, 1 numéro facile. 1-866-MAIRE29 (1-866-624-7329)
					<br>-<br>
					Pas de téléphone sous la main? Donnez un peu d'amour à votre ville en cliquant « J'aime »
				</p>
			</div>
		</header>





		<h2>Résultats</h2>
		<ul class="clearfix resultats">
		</ul>
		
		<h2>En direct</h2>
		<ul class="livefeed" id="ticker">
			
		</ul>
		<script type="text/html" id="skeleton-vote-call">
			<li><span class="tel">514-xxx-xxxx</span> vient tout juste de voter pour <span class="city">Hérouxville</span></li>
		</script>
		<script type="text/html" id="skeleton-vote-like">
			<li>Un vote de plus pour <span class="city">Hérouxville</span></li>
		</script>

		<script type="text/html" id="skeleton-city">
			<li class="col col-lg-3 city" data-city-id="">
				<article>
					<div class="visible-sm"><a href="tel:18666247329" >Vote pour <span class="city-name">Montreal</span></a></div>
					<div class="hidden-sm">
						<a href="" onclick="return false;">Vote pour <span class="city-name">Montreal</span></a>
					</div>
					<span class="vote-count hide">0</span>
					<span class="imgville" style="background-image:url(http://www.ameriquefrancaise.org/media-4410/Stade_Olympique_2.jpg)"></span>
				</article>
				<div class="fb-like" data-href="http://%CITY%.maireacademie.ca/" data-send="false" data-width="450" data-show-faces="false" data-layout="box_count" ></div>
			</li>
		</script>
	</section>
	<script src="//ajax.googleapis.com/ajax/libs/jquery/1.10.1/jquery.min.js"></script>
	<script src="./static/local/coffee/app.js"></script>
	<script>
	  (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
	  (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
	  m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
	  })(window,document,'script','//www.google-analytics.com/analytics.js','ga');

	  ga('create', 'UA-42100998-1', 'maireacademie.ca');
	  ga('send', 'pageview');

	</script>


	<script>
	  window.fbAsyncInit = function() {
	    // init the FB JS SDK
	    FB.init({
	      appId      : '152911244753826',                        // App ID from the app dashboard
	      xfbml      : true,                                  // Look for social plugins on the page
	      status     : true                                 // Check Facebook Login status
	    });

	    App.initFacebook();
	    
	  };

	  // Load the SDK asynchronously
	  (function(d, s, id){
	     var js, fjs = d.getElementsByTagName(s)[0];
	     if (d.getElementById(id)) {return;}
	     js = d.createElement(s); js.id = id;
	     js.src = "//connect.facebook.net/en_US/all.js";
	     fjs.parentNode.insertBefore(js, fjs);
	   }(document, 'script', 'facebook-jssdk'));
	</script>
</body>
</html>