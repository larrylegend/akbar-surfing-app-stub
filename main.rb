require 'sinatra'

before do
 	content_type 'application/json'
end

get '/' do
 	'{"ping": "pong"}'
end

get '/status.json' do
	'{"on_air": true}'
end
