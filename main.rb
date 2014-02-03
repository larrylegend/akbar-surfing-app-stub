require 'sinatra'
require 'json'

before do
 	content_type 'application/json'
end

get '/' do
 	'{"ping": "pong"}'
end

get '/locations' do
	content_type :json
	
	object = 
	[
		{ 	:name => 'Rockaway Beach',
			:temperature => 71.0,
			:conditions => 'Calm'
		},
		{ 	:name => 'Fire Island',
			:temperature => 40.0,
			:conditions => 'Choppy, hailing'
		},
		{ 	:name => 'Montauk',
			:temperature => 66.0,
			:conditions => 'Eight foot waves'
		}
	]

	# compact JSON:
	# object.to_json

	# pretty JSON:
	JSON.pretty_generate(object)
end
