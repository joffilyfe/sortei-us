require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/param'
require 'sinatra/flash'

class Config < Sinatra::Base
  configure do
    set :json_encoder, :to_json
    set :erb, :layout => :layout
    set :root, File.expand_path('../../', __FILE__)
  end  
end