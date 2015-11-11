class TwitterController < App

  get '/' do
    # session[:tweet_id] = '663063975488299008'
    # session[:tweet_id] = '661931597856382976'

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

    if (session[:twitter_token] and session[:twitter_token_secret])
      client = Twitter::REST::Client.new do |config|
        config.consumer_key        = ENV['TWITTER_CONSUMER_KEY']
        config.consumer_secret     = ENV['TWITTER_CONSUMER_KEY_SECRET']
        config.access_token        = session[:twitter_token]
        config.access_token_secret = session[:twitter_token_secret]
      end
      retweets = client.retweeters_of(session[:tweet_id], options = {:count => 100})
      users_list(retweets).to_json
    else
      {'error': 'Please authorize first the app.'}.to_json
    end

  end

  get '/oauth/authorize' do
    twitterOauth = TwitterOauth::Prepare
    twitterOauth.mount_url(request.base_url)
    consumer = twitterOauth.consumer
    response = twitterOauth.autorize_url(consumer)

    session[:request_token] = twitterOauth.token
    session[:request_token_secret] = twitterOauth.secret
    redirect to(response)
  end

  get '/oauth/confirm' do
    twitterOauth = TwitterOauth::Confirm
    access_token = twitterOauth.access_token(session[:request_token], session[:request_token_secret], params[:oauth_verifier])
    session[:twitter_token] = access_token.token
    session[:twitter_token_secret] = access_token.secret
    redirect to('/')
  end

  private
  
  def users_list(response)
    array = []    
    response.each do |t|
      hash = {}
      hash['name'] = t.name
      hash['account'] = t.screen_name
      array << hash
    end
    return array
  end
end
