case ENV['APP_ENV']
when 'development', 'test', 'production' then true
else raise "Wrong environment. Can be 'development', 'test', 'production'"
end
puts "Loading application core in #{ENV['APP_ENV']} environment"

## Load dependencies
require 'bundler/setup'
require 'date'
Bundler.require(:default, ENV['APP_ENV'])
require_relative 'object_extension.rb'
require './lib/telegram/app_manager.rb'

## Load env dependencies
case ENV['APP_ENV']
when 'development' then require_relative 'environments/development.rb'
when 'test'        then require_relative 'environments/test.rb'
when 'production'  then require_relative 'environments/production.rb'
end
