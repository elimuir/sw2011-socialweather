class TwitterController < ApplicationController
  def index
    Twitter.configure do |config|
      config.consumer_key = '3GvkKu6LtxCwdLgJn81qDw'
      config.consumer_secret = 'FjrdCHUcyoaP8YAm8fwClE2WYuvbNeISwajG5IWIbk'
      config.oauth_token = '17572797-a4wrBTbLmX4bDuB3O3nUHf6EMBzxAqoSPoWwcZn0Z'
      config.oauth_token_secret = '7qvYNZsvtiYOliBR2dcSNNO3y5SEa5T4hqG0mFK4BE'
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
