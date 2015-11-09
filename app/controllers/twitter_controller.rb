class TwitterController < App
  register Sinatra::Flash

  get '/callback' do
    
    if ENV['TWITTER_CONSUMER_KEY'] and ENV['TWITTER_CONSUMER_KEY_SECRET']
      # Get Twitter Access Token
      access_token = prepare_access_token(ENV['TWITTER_CONSUMER_KEY'], ENV['TWITTER_CONSUMER_KEY_SECRET'])
    
      # Get response for request RT/Search/etc
      response = access_token.request(:get, "/1.1/statuses/retweets/#{settings.tweet_id}.json")
      
      # Parse response from file
      @retweets = parse_retweet_list(JSON.parse(response.body))

    else
      p 'Please configure twitter keys.'
    end

    erb :list

  end

  private

  def prepare_access_token(oauth_token, oauth_token_secret)
    consumer = OAuth::Consumer.new(oauth_token, oauth_token_secret, { :site => "https://api.twitter.com", :scheme => :header })
    access_token = OAuth::AccessToken.new(consumer)
    return access_token
  end

  def parse_retweet_list(response)
      tweets_array = []
      response.each_with_index do |tweet, i|
        hash = {}
        hash['name'] = tweet['user']['name']
        hash['account'] = tweet['user']['screen_name']
        tweets_array << hash
      end
      return tweets_array
  end

end
