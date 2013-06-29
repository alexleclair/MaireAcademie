#Document ready
App = 

	config:
		maxTickerMessages:30
		cities:
			laval:'Laval'
			montreal:'Montréal'
			longueuil:'Longueuil'
			quebec:'Québec'
		endpoint:'http://localhost:8080/'
		img:
			laval:'background-image:url(https://fbcdn-sphotos-h-a.akamaihd.net/hphotos-ak-frc1/v/1044056_10151446375165064_589927772_n.jpg?oh=a01714580b26f8b13950ea18cd4f9c38&oe=51D161D3&__gda__=1372687733_6f3880be94764f88c29d9ab558782b04)'
			montreal:'background-image:url(https://fbcdn-sphotos-h-a.akamaihd.net/hphotos-ak-frc1/v/1005915_10151446375195064_1238059130_n.jpg?oh=9baa55de985485ae13bf8fc1b60331a9&oe=51D1021B&__gda__=1372689171_76117b8a2841703a60e4dffa50d1b0dd)'
			longueuil:'background-image:url(https://fbcdn-sphotos-h-a.akamaihd.net/hphotos-ak-prn1/v/1011180_10151446377270064_453307637_n.jpg?oh=0dd2e3633589950615d43e5a22ef154e&oe=51D0FD35&__gda__=1372685021_27940f882063d1ddfa37b47c886ee85a)'
			quebec:'background-image:url(https://fbcdn-sphotos-h-a.akamaihd.net/hphotos-ak-prn2/v/1045252_10151446375330064_1946028326_n.jpg?oh=4c614a47f107edc0c57731008f5237ba&oe=51D1363E&__gda__=1372710796_f48a8d6a1e0a9d5ac86fce304cde414d)'
	socket:null

	init: ->
		$results = $('.resultats');
		$skeleton = $('#skeleton-city')
		for key of @config.cities
			$city = $($skeleton.html())
			$iframe = $city.find('iframe');
			$iframe.attr('src', $iframe.attr('src').split('%CITY%').join(key))
			$city.attr('data-city-id', key)
			$city.find('.city-name').text(@config.cities[key]);
			$city.hide();
			$results.append($city)
			$city.slideDown('fast');
			$city.attr('id', 'city-'+key)
			$city.find('.imgville').attr 'style', App.config.img[key]
		@socket = io.connect @config.endpoint

		@socket.on 'vote', (data)->
			$ticker = $('#ticker');

			$skeleton = $('#skeleton-vote-'+data.type)
			$tick = $($skeleton.html());

			if data.type == 'call'
				tel = data.tel.split('+').join('').substr(2);
				tel = tel.substr(0,3)+'-'+tel.substr(3,3) + '-' + tel.substr(6) + 'xx';
				$tick.find('.tel').text(tel)

			$tick.find('.city').text(App.config.cities[data.city]);

			$ticker.prepend($tick.hide().fadeIn('fast'));

			$ticker.find('li:gt('+App.config.maxTickerMessages+')').remove();

		@socket.on 'stats', (data)->
			App.updateVotes data.city, data.stats.total;



	updateVotes:(city, voteCount)->
		$city = $('#city-'+city);
		$city.find('.vote-count').text(voteCount).removeClass('hide');

		if voteCount >= 1000
			$city.addClass('bignumber')
		else
			$city.removeClass('bignumber')


window.App = App;

$ ->
	App.init()