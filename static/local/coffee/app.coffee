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