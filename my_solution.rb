require "http"
require "json"
gmaps_key = ENV.fetch("GMAPS_KEY")
pp "Where are you"
location=gets.chomp
url="https://maps.googleapis.com/maps/api/geocode/json?address="+location.gsub(" ","%20")+"&key=#{gmaps_key}"
raw= HTTP.get(url)
parsed=JSON.parse(raw)
locHash= parsed.fetch("results")[0].fetch("geometry").fetch("location")
lat=locHash.fetch("lat")
lng=locHash.fetch("lng")
pirate_weather_key = ENV.fetch("PIRATE_WEATHER_KEY")
pirate_weather_url = "https://api.pirateweather.net/forecast/" + pirate_weather_key + "/#{lat},#{lng}"
raw_response = HTTP.get(pirate_weather_url)
parsed_response = JSON.parse(raw_response)
currently= parsed_response.fetch("currently")
future=parsed_response.fetch("hourly")
summary=currently.fetch("summary")
temperature=currently.fetch("temperature")
pp "The weather is currently #{summary} and the temperature is #{temperature}"
pp future.fetch("data")[0].fetch("precipProbability")
10.times do |count|
  precipProb=future.fetch("data")[count].fetch("precipProbability")
  if precipProb > 0.1
      pp "There is a #{precipProb*100}% chance of rain in #{count} hours"
  end
end
 
