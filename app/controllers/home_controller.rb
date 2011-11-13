class HomeController < ApplicationController
  def index
  end
  
  def tweets
    twitterClient = Twitter::Client.new
    rawTweets = twitterClient.search("tag:" + params[:keyword])
    
    @tweets = []
    
    rawTweets.each do |tweet|
      @tweets << tweet #.text
    end
  end
  
  def images
    FlickRaw.api_key="203deba46390fca2a58135c32d8bf997"
    FlickRaw.shared_secret="6d124ffa642143b4"

    #location_id = flickr.places.find(:query => 'Seattle, WA').places[0].place.place_id

    locations = flickr.places.findByLatLon(:lat => '47.6',:lon => '-122.3') #todo:make it by IP address
    location_id = locations[0].place_id

    list = flickr.photos.search(:tags => params[:tag], :place_id => location_id)

    # TODO: add sorting by time

    @images = []

    list.length.times do |i|
      img = list[i]

      id     = img.id
      secret = img.secret
      info = flickr.photos.getInfo :photo_id => id, :secret => secret
      @images << FlickRaw.url_b(info)

      if i == 5
        break
      end
    end

#    list.each do |img|
#      id     = img.id
#      secret = img.secret
#      info = flickr.photos.getInfo :photo_id => id, :secret => secret
#      @images << FlickRaw.url_b(info)
#    end

  end

end
