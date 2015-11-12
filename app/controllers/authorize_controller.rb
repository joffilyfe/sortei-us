class AuthorizeController < App  

  get '/' do
    if session[:twitter_token]
      redirect '/twitter'
    else
      redirect to('/request')
    end
  end

  get '/request' do
    twitterOauth = TwitterOauth::Prepare
    twitterOauth.mount_url(request.base_url)
    consumer = twitterOauth.consumer
    response = twitterOauth.autorize_url(consumer)

    session[:request_token] = twitterOauth.token
    session[:request_token_secret] = twitterOauth.secret
    redirect to(response)
  end

  get '/confirm' do
    twitterOauth = TwitterOauth::Confirm
    access_token = twitterOauth.access_token(session[:request_token], session[:request_token_secret], params[:oauth_verifier])
    session[:twitter_token] = access_token.token
    session[:twitter_token_secret] = access_token.secret
    redirect '/twitter'
  end
end