## Set application environment
env_arg = ARGV.find { |args| args.include?('APP_ENV') }
env = env_arg ? env_arg.split('=').last : ENV['APP_ENV'] 

APP_ENV ||= case env
when nil, 'development' then :development
when 'test'             then :test
when 'production'       then :production
else raise "Wrong environment. Can be 'development', 'test', 'production'"
end
puts "Loading application core in #{APP_ENV} environment"


## Load dependencies
require 'bundler/setup'
require 'date'
Bundler.require(:default, APP_ENV)
require './lib/telegram/app_manager.rb'


## Load env dependencies
case APP_ENV
when :development then require_relative 'environments/development.rb'
when :test        then require_relative 'environments/test.rb'
when :production  then require_relative 'environments/production.rb'
end
