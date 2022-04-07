# frozen_string_literal: false

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.1.1'

## System gems
gem 'dotenv', '2.7.6' # load env files. SHOULD BE THE FIRST, AND AFTER GEMS THAT REQUIRE ENVs
gem 'rubocop', '1.26.1', require: false
gem 'amazing_print', '1.4.0' # pretty prints for ruby objects
gem 'pry-byebug', '3.9.0' # debugger tool
gem 'rake', '13.0.6' # ruby tasks
gem 'require_all', '3.0.0' # auto require all files in directory

## Background processing
gem 'hiredis', '0.6.3' # Redis adapter for sidekiq
gem 'redis-namespace', '1.8.2' # To split sidekiq data in redis
gem 'sidekiq', '6.4.1' # background processing
gem 'sidekiq-scheduler', '3.1.1' # scheduled background workers
gem 'sidekiq-statistic', git: 'https://github.com/davydovanton/sidekiq-statistic.git', ref: 'f7476c9'
gem 'sinatra', '~> 2.0', require: false # UI for sidekiq and web app

## Databases
gem 'activerecord', '6.1.5' # DB ORM
gem 'standalone_migrations', '7.1.0' # rails-like DB migrations
gem 'pg', '1.3.4' # postgres DB
gem 'redis', '4.6.0' # redis DB

## Third-party dependencies
gem 'colorize', '0.8.1' # String colorizer

## API
gem 'telegram-bot', '0.15.4' # Telegram API
gem 'telegram-bot-types', '0.7.0'

## Business logic
gem 'dry-validation', '1.8.0' # Validations for service objects

## Extensions
gem 'hashie', '5.0.0'

group :test do
  gem 'database_cleaner-active_record', '2.0.1'
  gem 'factory_bot', '6.2.1'
  gem 'faker', git: 'https://github.com/stympy/faker.git', branch: 'master'
  gem 'mock_redis', '0.30.0'
  gem 'shoulda-matchers', '5.1.0'
  gem 'rspec', '3.11.0'
end
