class ApplicationController < ActionController::Base
  protect_from_forgery
  require 'xmlsimple'
  helper_method :getCurrentTemp
  helper_method :getCurrentCondition

  def getCurrentTemp()
      weatherString = RestClient.get 'http://weather.yahooapis.com/forecastrss?w=2490383'
      weatherParsed = XmlSimple.xml_in(weatherString)
      @currentTemp = weatherParsed['channel'][0]['item'][0]['condition'][0]['temp']
   end

  def getCurrentCondition()
      weatherString = RestClient.get 'http://weather.yahooapis.com/forecastrss?w=2490383'
      weatherParsed = XmlSimple.xml_in(weatherString)
      @currentCond = weatherParsed['channel'][0]['item'][0]['condition'][0]['text']
  end
end
