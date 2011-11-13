class HomeController < ApplicationController
  def index
  end
  
  def tweets
    twitterClient = Twitter::Client.new
    rawTweets = twitterClient.search("tag:" + params[:keyword])
    
    @tweets = []
    
    rawTweets.each do |tweet|
      @tweets << tweet.text
    end
  end
  
  def images
    FlickRaw.api_key="203deba46390fca2a58135c32d8bf997"
    FlickRaw.shared_secret="6d124ffa642143b4"

    list = flickr.photos.search(:tags => 'Volcano')
    @images = []
    
    list.each do |img|
      id     = img.id
      secret = img.secret
      info = flickr.photos.getInfo :photo_id => id, :secret => secret
      images << FlickRaw.url_b(info)
    end

  end

end
