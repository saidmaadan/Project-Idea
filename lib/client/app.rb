require 'rubygems'
require 'sinatra'
require 'omniauth-twitter'
require 'pry'
require '../idea.rb'

enable :sessions

set :bind, '0.0.0.0'



helpers do
  def admin?
    session[:admin]
  end
end

use OmniAuth::Builder do
  provider :twitter, '82hJ55dxqop9rCtVvMtUGthPv', 'a0nK7yyjBUMwBOlerbnBQQkD3FMC9J2RU9xVROBN1Z2QmRHNnZ'
  # {
  #     :secure_image_url => 'true',
  #     :image_size => 'original',
  #     :authorize_params => {
  #       :force_login => 'true',
  #       :lang => 'pt'
  #     }
  #   }
end



get '/' do
  erb :index
end

get '/signup' do
  erb :signup
end

get '/signin' do
  redirect to("/auth/twitter")
  # erb :signin
end

get '/auth/twitter/callback' do
  session[:admin] = true
  session[:username] = env['omniauth.auth']['info']['name']
  "<h1>Hi #{session[:username]}!</h1>"
  # env['omniauth.auth'] ? session[:admin] = true : halt(401,'Not Authorized')
  # "You are now logged in"
  redirect '/new'
end


# post '/signup' do
#   # puts params
#   # @name = RPS::CreateNewUser.new.run(params[:name])
#   # erb :signup
# end

get '/browse' do
  # get the 12 latest posts
  @posts = Post.all(:order => [ :id.desc ], :limit => 12)
  erb :browse
end

get '/new' do
  erb :new
end

get '/post' do
  erb :post
end
