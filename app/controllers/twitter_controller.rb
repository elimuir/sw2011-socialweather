class TwitterController < ApplicationController
  def index
    Twitter.configure do |config|
      config.consumer_key = 'RKDZvn2PIs1QOjq4ZmlHvg'
      config.consumer_secret = 'mVDmASXsRkd3YJQeAdptoHmelEMnKrxzVWmq1YVuuU'
      config.oauth_token = '283133704-MIgt6LfOECfrhCQyGgXAflC83p3qqNH55mNV3M'
      config.oauth_token_secret = 'c5N0xuzvYPSXI7T75ZLsuNcdj80mBsobLiVsreLJA8'
    end
    
    client = Twitter::Client.new
    
    city = params[:city]
    weather = params[:weather]
    tweets = client.search("twitpic " + city + " " + weather)
    
    @pictures = []

    tweets.each do |t|
      urls = extract_urls(t.text)
      urls.each do |url|
        resolvedURL = client.resolve(url)[url]
        if (resolvedURL.include?("twitpic"))
          uri = URI.parse(resolvedURL)
          id = uri.path
          tag = "<a href=\"#{resolvedURL}\" target=\"newwin\"><img src=\"http://twitpic.com/show/thumb#{id}.jpg\"/></a>"

          @pictures << tag
        end
      end
    end  
    
    @pictures = @pictures.uniq
    
    respond_to do |format|
      format.html
      format.json {render :json => @pictures}
    end  
  end

  def login
  end

  def finalize
  end
  
  private
  
  def extract_urls(text, urls = [])
    url_regex =  Regexp.new('\b(([\w-]+://?|www[.])[^\s()<>]+(?:\([\w\d]+\)|([^[:punct:]\s]|/)))')
    url_regex.match(text) do |match|
      urls << match[0]
      extract_urls(match.post_match, urls)
    end
    urls
  end
  
end
