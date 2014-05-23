require 'rubygems'
require 'sinatra'
require 'pry'
require '../idea.rb'

enable :sessions

set :bind, '0.0.0.0'

get '/' do
  erb :index
end

get '/signup' do
  erb :signup
end

get '/signin' do
  erb :signin
end
post '/signup' do
  # puts params
  # @name = RPS::CreateNewUser.new.run(params[:name])
  # erb :signup

end

get '/new' do
  erb :new
end
