require 'sinatra'
require 'json'
require 'sinatra/activerecord'
require './config/environments' #database configuration
require './models/location'

# before do
#  	content_type 'application/json'
# end

get '/' do
	erb :index
end

# get '/' do
#  	'{"ping": "pong"}'
# end

get '/locations' do
	@locations = Location.all
	erb :locations
end

get '/api/locations' do
	content_type :json

	@locations = Location.all
	@locations.to_json
end

get '/api/locations/:id' do
	content_type :json

 	Location.where(:id => params['id']).first.to_json
end


# get '/api/locations.json' do
# 	content_type :json
	
# 	object = 
# 	[
# 		{ 	:name => 'Rockaway Beach',
# 			:temperature => 71.0,
# 			:conditions => 'Calm'
# 		},
# 		{ 	:name => 'Fire Island',
# 			:temperature => 40.0,
# 			:conditions => 'Choppy, hailing'
# 		},
# 		{ 	:name => 'Montauk',
# 			:temperature => 66.0,
# 			:conditions => 'Eight foot waves'
# 		}
# 	]

# 	# compact JSON:
# 	# object.to_json

# 	# pretty JSON:
# 	JSON.pretty_generate(object)
# end

post '/submit' do
		if params.has_key?('name') and params.has_key?('temperature') and params.has_key?('conditions')
		@location = Location.new(
		:name => params['name'], 
     	:temperature => params['temperature'], 
     	:conditions => params['conditions'])

     	if @location.save
			redirect '/locations'
		else
			"Sorry, there was an error saving!"
		end
	else
		"Sorry, there was an error!"
    end
end

post '/api/locations' do
	content_type :json

		if params.has_key?('name') and params.has_key?('temperature') and params.has_key?('conditions')
			@location = Location.new(
			:name => params['name'], 
	     	:temperature => params['temperature'], 
	     	:conditions => params['conditions'])

	     	if @location.save
				@location.to_json
			else
				object = {:error => "There was an error saving."}
			end
		else
			object = {:error => "There was an error."}
	    end
end
  
put '/api/locations/:id' do
  selectedLocation = Location.where(:id => params['id']).first
  if selectedLocation
    if params.has_key?('name')
      selectedLocation.name = params['name']
    end
    if params.has_key?('temperature')
      selectedLocation.temperature = params['temperature']
    end
    if params.has_key?('conditions')
      selectedLocation.conditions = params['conditions']
    end
    selectedLocation.save
  end
end
 
delete '/api/locations/:id' do
	content_type :json
	
	if Location.where(:id => params['id']).destroy_all
		'{}'
	else 
		object = {:error => "There was an error."}
	end
end