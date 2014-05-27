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
# alias_method :h, :escape_html
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
  # puts params
  # @name = RPS::CreateNewUser.new.run(params[:name])
  # erb :signup
end

get '/private' do
  halt(401,'Not Authorized') unless admin?
end

# get '/browse' do
#   # get the 12 latest posts
#   @posts = Post.all(:order => [ :id.desc ], :limit => 12)
#   erb :browse
get '/browse' do
   protected
   @posts = Post.all
   @title = 'All Posts'
   erb :browse
end

post '/browse' do
   protected
   @post = Post.create(:title => params[:title], :description => params[:description], :category => params[:category], :created_at => Time.now)
    # @post.save
    redirect '/browse'

# post = Post.new(
   #  :title => params[:title],
   #  :description => params[:description],
   #  :category => params[:category],
   #  :created_at => Time.now
   #  #:updated_at => Time.now
   #  )
    # if @post.save
    # end
  #redirect to("/#{@post.id}")
#    @post = Post.create(
#   :title      => "My first DataMapper post",
#   :description       => "A lot of text ...",
#   :category => "web App",
#   :created_at => Time.now
# )
#    @post.save
#    redirect '/browse'
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





# post '/post' do
#   protected
#   p = Post.new
#   p.attributes = {
#     :title => params[:title],
#     :description => params[:description],
#     :category => params[:category],
#     :created_at => Time.now,
#     :updated_at => Time.now
#   }
#    if p.save
#    redirect '/browse'
#   else
#     redirect '/post'
#   end
# end

# get '/rss.xml' do
#   @posts = posts.all :order => :id.desc
#   builder :rss
# end

# get '/:id' do
#   @post = Post.get params[:id]
#   @title = "Edit note ##{params[:id]}"
#   if @post
#     erb :edit
#   else
#     redirect '/', :error => "Can't find that note."
#   end
# end

# put '/:id' do
#   p = Post.get params[:id]
#   unless p
#     redirect '/', :error => "Can't find that note."
#   end
#   p.attributes = {
#     :title => params[:title],
#     :description => params[:description],
#     :category => params[:category],
#     :updated_at => Time.now
#   }
#   if p.save
#     redirect '/'
#   else
#     redirect '/'
#   end
# end

# get '/:id/delete' do
#   @post = Post.get params[:id]
#   @title = "Confirm deletion of note ##{params[:id]}"
#   if @post
#     erb :delete
#   else
#     redirect '/'
#   end
# end

# delete '/:id' do
#   p = Post.get params[:id]
#   if p.destroy
#     redirect '/'
#   else
#     redirect '/'
#   end
# end

# get '/:id/complete' do
#   p = Post.get params[:id]
#   unless p
#     redirect '/'
#   p.attributes = {
#     :complete => n.complete ? 0 : 1, # flip it
#     :updated_at => Time.now
#   }
#   if n.save
#     redirect '/', :notice => 'Note marked as complete.'
#   else
#     redirect '/', :error => 'Error marking note as complete.'
#   end
# end



