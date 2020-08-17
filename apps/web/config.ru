# Require rails config
require_relative 'config/environment'

# Require codebase
require './config/environment.rb'
require './lib/admin_bot.rb'
require './lib/example_bot.rb'
require './lib/jenia_bot.rb'
require './lib/pdr_bot.rb'
require './lib/web.rb'

run Rails.application
