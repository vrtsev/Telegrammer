# frozen_string_literal: false

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.2'

## System gems
gem 'dotenv' # load env files. SHOULD BE THE FIRST, AND AFTER GEMS THAT REQUIRE ENVs
gem 'i18n'
gem 'i18n-spec'
gem 'pry-byebug'
gem 'rake'
gem 'require_all' # auto require all files in directory

## Background processing
gem 'hiredis' # Redis adapter for sidekiq
gem 'redis-namespace' # To split sidekiq data in redist
gem 'sidekiq'
gem 'sidekiq-scheduler'
gem 'sidekiq-statistic', git: 'https://github.com/davydovanton/sidekiq-statistic.git', ref: 'f7476c9'
gem 'sinatra', '~> 2.0', require: false # UI for sidekiq and web app

## Databases
gem 'pg'
gem 'redis'
gem 'sequel' # DB ORM

## Third-party dependencies
gem 'colorize' # String colorizer
gem 'jwt'
gem 'rotp'

## API
gem 'telegram-bot', '0.14.4'

## Business logic
gem 'dry-validation'
gem 'ruby-enum'
gem 'trailblazer-operation' # Service objects for business logic

## Extensions
gem 'hashie'

group :test do
  gem 'database_cleaner'
  gem 'fabrication'
  gem 'faker', git: 'https://github.com/stympy/faker.git', branch: 'master'
  gem 'mock_redis'
  gem 'rspec'
end

## Web app
gem 'bootsnap', '>= 1.4.2', require: false
gem 'puma', '~> 4.1', require: false
gem 'rails', '6.0.0', require: false
gem 'turbolinks', '~> 5', require: false
gem 'zeitwerk'

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2', require: false
  gem 'spring', require: false
  gem 'spring-watcher-listen', '~> 2.0.0', require: false
  gem 'web-console', '>= 3.3.0', require: false
end
