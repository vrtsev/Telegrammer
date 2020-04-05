# Require system libs
require 'sinatra'
require 'sinatra/base'
require 'sinatra/cookies'
require 'jwt'

# Require codebase
require './config/environment.rb'
require './lib/admin_bot.rb'
require './lib/jenia_bot.rb'
require './lib/pdr_bot.rb'

# require web app dependencies
loader = Zeitwerk::Loader.new
loader.push_dir('apps/web/config')
loader.push_dir('apps/web/controllers')
loader.setup

Routes.each do |route|
  map(route[:path]) { run route[:to].new }
end
