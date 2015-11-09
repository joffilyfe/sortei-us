require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/param'
require 'sinatra/flash'
require 'oauth'

class App < Sinatra::Base
  register Sinatra::Flash
  enable :sessions
  configure do
    set :json_encoder, :to_json
    set :erb, :layout => :layout
    set :root, File.expand_path('../../', __FILE__)
    
    # Set tweet id, now we can run your raffle
    set :tweet_id, '663063975488299008'
  end  
end