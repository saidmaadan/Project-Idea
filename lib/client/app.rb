require 'rubygems'
require 'sinatra'
require 'omniauth-twitter'
require 'data_mapper'
require 'dm-core'
require 'dm-migrations'
require 'pry'
require '../idea.rb'

enable :sessions
set :bind, '0.0.0.0'



DataMapper.setup(:default, 'sqlite::memory:')
DataMapper.setup(:default, "sqlite3://#{Dir.pwd}/post.db")

class Post
  include DataMapper::Resource
  property :id, Serial
  property :title, Text, :required => true
  property :description, Text, :required => true
  property :category, Text, :required => true
  property :created_at, DateTime
  property :updated_at, DateTime

end

DataMapper.auto_upgrade!
module PostHelpers
  def find_posts
    @posts = Post.all
  end

  def find_post
    Post.get(params[:id])
  end

  def create_post
    @post = Post.create(params[:post])
  end
end


class PostController < Sinatra::Base
  enable :method_override

  helpers PostHelpers
end

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

get '/signout' do
  session[:admin] = nil
  "You are now logged out"
  redirect '/'
end

post '/signup' do

end

get '/private' do
  halt(401,'Not Authorized') unless admin?
end

get '/browse' do
   protected
   @posts = Post.all
   @title = 'All Posts'
   erb :browse
end

post '/browse' do
   protected
   @post = Post.create(:title => params[:title], :description => params[:description], :category => params[:category], :created_at => Time.now)
    redirect '/browse'
end

get '/new' do
  protected
  erb :new
end

get '/post' do
  protected
  @post = Post.new
  erb :post
end

get '/:id' do
  @post = Post.get(params[:id])
  erb :result
end

get '/:id/edit' do
  protected
  @post = Post.get(params[:id])
  erb :edit
end

put '/:id' do
  protected!
  post = Post.get(params[:id])
  if post.update(params[:post])
   puts "Post successfully updated"
  end
  redirect to("/#{post.id}")
  end

  delete '/:id' do
    protected!
    if Post.get(params[:id]).destroy
      pust "Post deleted"
    end
    redirect to('/browse')
  end
