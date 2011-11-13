class ApplicationController < ActionController::Base
  protect_from_forgery
  require 'xmlsimple'
  helper_method :getCurrentTemp
  helper_method :getCurrentCondition

  def getCurrentTemp(lat, lon)
      latitude = lat.to_s()
      longitude = lon.to_s()
      location = "http://where.yahooapis.com/geocode?location=" + latitude + "+" + longitude + "&gflags=R"
      woeidString = RestClient.get location
      woeidParsed = XmlSimple.xml_in(woeidString)
      woeid = woeidParsed['Result'][0]['woeid']

      weatherUrl = "http://weather.yahooapis.com/forecastrss?w=" + woeid[0]
      weatherString = RestClient.get weatherUrl
      weatherParsed = XmlSimple.xml_in(weatherString)
      @currentTemp = weatherParsed['channel'][0]['item'][0]['condition'][0]['temp']
   end

  def getCurrentCondition(lat, lon)
      latitude = lat.to_s()
      longitude = lon.to_s()
      location = "http://where.yahooapis.com/geocode?location=" + latitude + "+" + longitude + "&gflags=R"
      woeidString = RestClient.get location
      woeidParsed = XmlSimple.xml_in(woeidString)
      woeid = woeidParsed['Result'][0]['woeid']

      weatherUrl = "http://weather.yahooapis.com/forecastrss?w=" + woeid[0]
      weatherString = RestClient.get weatherUrl
      weatherParsed = XmlSimple.xml_in(weatherString)
      @currentTemp = weatherParsed['channel'][0]['item'][0]['condition'][0]['text']
  end
end
