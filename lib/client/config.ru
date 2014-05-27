require 'sinatra/base'
require './app'

run Sinatra::Application
map('/browse') { run PostController }
map('/browse') { run Website }
