class ApplicationController < App
  helpers Sinatra::Param
  enable :sessions
  register Sinatra::Flash

  get '/' do
    erb :index
  end

  post '/register' do
    unless @user = User.where(email: params[:email]).first
      @user = User.create(user_params)
      @user.save
    else
      flash[:register] = 'Zé, você já está concorrendo'
    end

    erb :register
  end

  get '/users/?' do
    content_type :json
    @users = User.all
    @users.to_json
  end

  get '/users/:id/?' do
    @user = User.find_by_id(params[:id])
    @user.to_json
  end

  private
    def user_params 
      count = Count.find(1)
      param :name, String, max_length: 32, required: true
      param :email, String, max_length: 32, required: true
      count.counter += 1
      count.save
      {
        name: params[:name],
        email: params[:email],
        number: count.counter
      }
    end
end