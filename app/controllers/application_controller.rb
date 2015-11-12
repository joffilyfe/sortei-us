class ApplicationController < App
  helpers Sinatra::Param
  enable :sessions
  register Sinatra::Flash

  get '/' do
    erb :index
  end
end