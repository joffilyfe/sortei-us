class TwitterController < App

  get '/callback' do
    
    if ENV['TWITTER_CONSUMER_KEY'] and ENV['TWITTER_CONSUMER_KEY_SECRET']
      # Get Twitter Access Token
      access_token = prepare_access_token(ENV['TWITTER_CONSUMER_KEY'], ENV['TWITTER_CONSUMER_KEY_SECRET'])
    
      # Get response for request RT/Search/etc
      response = access_token.request(:get, "/1.1/statuses/retweets/#{settings.tweet_id}.json")
      
      # Parse response from file
      rsp = JSON.parse(response.body)
      p rsp.to_json
    else
      p 'Please configure twitter keys.'
    end

  end

  private

  def prepare_access_token(oauth_token, oauth_token_secret)
    consumer = OAuth::Consumer.new(oauth_token, oauth_token_secret, { :site => "https://api.twitter.com", :scheme => :header })
    access_token = OAuth::AccessToken.new(consumer)
    return access_token
  end
end
