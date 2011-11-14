class HomeController < ApplicationController
  def index
#    redirect_to "http://getweatherful.com/" # TODO: temporary redirection until we launch the site
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
    list = flickr.photos.search(:tags => params[:tag], :lat => params[:lat].to_f, :lon => params[:long])

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

      respond_to do |format|
        format.html
        format.json {render :json => @images}
      end
  end

end
