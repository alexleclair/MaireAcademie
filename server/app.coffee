App = 
		io: null
		redis:require('redis')
		redisWorker: null
		fs:null
		httpServer:null
		express:null
		config:
			port:8080
			redisHost:'top.30mars.ca'
			redisPort:6379
			wwwPath:'./../'
			twilio:
				responses:
					intro:'./twilio/intro.xml'
					outro:'./twilio/outro.xml'
		stats: {}


		init: (config)->
				# Load libs only on init
				if config?
						@config = @_mergeOptions @config config

				@fs = require('fs');
				express = require('express')
				@express = express.call(this);
				@httpServer = require('http').createServer(@express);
				@httpServer.listen(@config.port)
				@io = require('socket.io').listen(@httpServer);
				@io.set('log level', 1);

				@express.get '/api/*', @_handleAPICalls
				@express.post '/api/*', @_handleAPICalls
				@express.get '/*', @_handleHttpRequest

				@express.use express.bodyParser()
				@express.use (err, req, res, next)->
				  console.error(err.stack);
				  res.send(500, 'Oops ! Something went super wrong.');

				@redisWorker = @redis.createClient(App.config.redisPort, App.config.redisHost)
				@_updateCityStats('montreal');

		_handleAPICalls: (req, res) ->
			parts = req.url.split('?')[0].split('/');
			if parts.length < 4
				res.writeHead '500'
				res.end 'API calls expect at least a module/parameter combo.'
				return;
			module = parts[2];
			method = parts[3];
			
			switch module
				when "twilio" 
					App._handleTwilioCall method, req, res;
					return false;
				when "vote"
					voteData = 
						identity: req.connection.remoteAddress
						type:'like'

					if req.headers['X-Real-IP']?
						voteData.identity = req.headers['X-Real-IP'];

					result = App._registerVote method, voteData;
					if result
						res.writeHead '200'
						return res.end JSON.stringify {status:'ok', value:result}
					else
						res.writeHead '500'
						return res.end JSON.stringify {status:'failed'}
				else
					res.writeHead '404'
					res.end 'Module ' + module + ' not found'


		_handleTwilioCall: (method, req,  res) ->
			switch method
				when 'call'
					console.log 'call'
					file = App.config.twilio.responses.intro
					if req.query.Digits?

						cities = [null, 'laval', 'montreal', 'longueuil', 'quebec'];
						voteData = 
							identity: req.query.From
							type:'call'

						App._registerVote(cities[req.query.Digits], voteData)
						file = App.config.twilio.responses.outro

					App.fs.readFile file, (err, data)->
						if(err)
							res.writeHead '500'
							return res.end('Error loading xml file')
						res.setHeader 'Content-Type', 'text/xml'
						res.writeHead '200'
						res.end data;
				else
					res.writeHead '404'
					res.end 'Method not found'


		_registerVote: (city, data) ->
			cities = 
				laval : 0
				montreal : 1
				longueuil : 2
				quebec : 3

			if not city? || not cities[city]?
				return false

			key = 'votes:'+city
			console.log('New vote for '+city+' from '+data.identity)
			App.io.sockets.emit('vote_count', clients);
			if data.type == 'call'
				return App.redisWorker.zadd 'maireacademie:votes:'+city, new Date().getTime(), JSON.stringify data;
			else
				return App.redisWorker.zadd 'maireacademie:votes:fb:'+city, new Date().getTime(), JSON.stringify data;

		_updateCityStats: (city)->
			App.redisWorker.zcard 'maireacademie:votes:'+city, (err, callVotes)->
				request = require("request");
				request 'http://api.facebook.com/restserver.php?method=links.getStats&urls=http://'+city+'.maireacademie.ca/&format=json', (error, response, body)->
					json = JSON.parse(body);
					console.log json;
			#http://api.facebook.com/restserver.php?method=links.getStats&urls=http://montreal.maireacademie.ca/&format=json

		_handleHttpRequest: (req, res) ->
				file = req.url.split('?')[0];
				file = if file == '/' then 'index.html' else file;
				file = file.split('..').join('');

				path = __dirname + '/' + App.config.wwwPath + file;

				App.fs.readFile path, (err, data)->
						if(err)
								res.writeHead '500'
								return res.end('Error loading '+file)
						res.writeHead '200'
						res.end data;



App.init();