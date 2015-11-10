class TwitterController < App
  register Sinatra::Flash


  get '/' do
    if session[:tweet_id]
      erb :'admin/index'
    else
      redirect to('/admin/configure')
    end
  end

  get '/admin/configure' do
    @tweet_id = session[:tweet_id].to_s || ''
    erb :'admin/configure'
  end

  post '/admin/configure' do

    if not params[:id].empty?
      session[:tweet_id] = params[:id]
      redirect to('/')
    else
      redirect to('/admin/configure')
    end
  end

  get '/callback' do
    content_type :json
    
    if ENV['TWITTER_CONSUMER_KEY'] and ENV['TWITTER_CONSUMER_KEY_SECRET']
      # Get Twitter Access Token
      access_token = prepare_access_token(ENV['TWITTER_CONSUMER_KEY'], ENV['TWITTER_CONSUMER_KEY_SECRET'])
    
      # Get response for request RT/Search/etc
      response = access_token.request(:get, "/1.1/statuses/retweets/#{session[:tweet_id]}.json")
      
      # Parse response from file
      retweets = parse_retweet_list(JSON.parse(response.body)).to_json
    else
      {'error': 'Please configure yours twitter keys.'}.to_json
    end

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
