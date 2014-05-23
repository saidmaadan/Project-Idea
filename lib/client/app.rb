require 'rubygems'
require 'sinatra'
require 'pry'
require '../idea.rb'

enable :sessions

set :bind, '0.0.0.0'

get '/' do
  erb :layout
end

get '/signup' do
  erb :signup
end

post '/signup' do
  # puts params
  # @name = RPS::CreateNewUser.new.run(params[:name])
  # erb :signup
end

get '/browse' do
  erb :browse
end
