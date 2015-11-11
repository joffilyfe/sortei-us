require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/param'
require 'sinatra/flash'
require 'oauth'
require 'twitter'

class App < Sinatra::Base
  register Sinatra::Flash
  enable :sessions
  
  configure do
    set :json_encoder, :to_json
    set :erb, :layout => :layout
    set :root, File.expand_path('../../', __FILE__)
  end
end