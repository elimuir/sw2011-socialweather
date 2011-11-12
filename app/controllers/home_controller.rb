class HomeController < ApplicationController
  def index
  end
  
  def tweets
    twitterClient = Twitter::Client.new
    rawTweets = twitterClient.search("tag:weather")
    
    @tweets = []
    
    rawTweets.each do |tweet|
      @tweets << tweet.text
    end
    
  end

end
