require 'rest_client'
require 'xmlsimple'

def getCurrentTemp(temperature)
    # weather = RestClient.get 'http://graphical.weather.gov/xml/sample_products/browser_interface/ndfdBrowserClientByDay.php?lat=47.45&lon=-122.30&format=24+hourly&numDays=1'
    weatherString = RestClient.get 'http://weather.yahooapis.com/forecastrss?w=2490383'
    weatherParsed = XmlSimple.xml_in(weatherString)
    puts weatherParsed['channel'][0]['item'][0]['condition'][0]['temp']
    #puts weatherParsed['channel'][0]['item'][0]['condition'][0]['text']
end
