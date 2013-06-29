#Document ready
App = 

	config:
		cities:
			laval:'Laval'
			montreal:'Montréal'
			longueuil:'Longueuil'
			quebec:'Québec'

	init: ->
		$results = $('.resultats');
		$skeleton = $('#skeleton-city')
		for key of @config.cities
			$city = $($skeleton.html())
			$city.attr('data-city-id', key)
			$city.find('.city-name').text(@config.cities[key]);
			$city.hide();
			$results.append($city)
			$city.slideDown('fast');
			$city.attr('id', 'city-'+key)
$ ->
	App.init()