require 'rubygems'
require 'sinatra'
require 'omniauth-twitter'
require 'pry'
require '../idea.rb'

enable :sessions
set :bind, '0.0.0.0'

use OmniAuth::Builder do
  provider :twitter, '82hJ55dxqop9rCtVvMtUGthPv', 'a0nK7yyjBUMwBOlerbnBQQkD3FMC9J2RU9xVROBN1Z2QmRHNnZ'
  {
      :secure_image_url => 'true',
      :image_size => 'original',
      :authorize_params => {
        :force_login => 'true',
        :lang => 'pt'
      }
    }
end

helpers do
  def admin?
    session[:admin]
  end

  def protected
   unless admin?
    redirect '/'
  end
end
end






get '/' do
  erb :index
end

get '/signup' do
  erb :signup
end

get '/signin' do
  redirect to("/auth/twitter")
end

get '/auth/twitter/callback' do
  env['omniauth.auth'] ? session[:admin] = true : halt(401,'Not Authorized')
  session[:username] = env['omniauth.auth']['info']['name']
  "<h1>Hi #{session[:username]}!</h1>"
  redirect '/new'
end


post '/signup' do
  # puts params
  # @name = RPS::CreateNewUser.new.run(params[:name])
  # erb :signup
end

get '/private' do
  halt(401,'Not Authorized') unless admin?
end

get '/browse' do
   protected
   erb :browse
end

get '/new' do
  protected
  erb :new
end

get '/post' do
  protected
  erb :post

end

get '/signout' do
  session[:admin] = nil
  "You are now logged out"
  redirect '/'
end
