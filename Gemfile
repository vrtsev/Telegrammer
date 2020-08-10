source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

## System gems
gem 'dotenv' # load env files. SHOULD BE THE FIRST, AND AFTER GEMS THAT REQUIRE ENVs

# TODO replace to zeitwerk
gem 'require_all' # auto require all files in directory
gem 'pry-byebug'
gem 'rake'
gem 'i18n-spec'

## Background processing
gem 'sidekiq'
gem 'sidekiq-scheduler'
gem 'sidekiq-statistic', git: 'https://github.com/davydovanton/sidekiq-statistic.git', ref: 'f7476c9'
gem 'hiredis' # Redis adapter for sidekiq
gem 'redis-namespace' # To split sidekiq data in redist
gem 'sinatra', '~> 2.0', require: false # UI for sidekiq and web app

## Web app
gem 'zeitwerk'
gem 'rails', '6.0.0', require: false
gem 'puma', '~> 4.1'
gem 'turbolinks', '~> 5', require: false
gem 'bootsnap', '>= 1.4.2', require: false

group :development do
  # Web app
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

## Databases
gem 'pg'
gem 'sequel' # DB ORM
gem 'redis'

## Third-party dependencies
gem 'colorize' # String colorizer
gem 'rotp'
gem 'jwt'

## API
gem 'telegram-bot', '0.14.4'

## Business logic
gem 'telegram-bot_manager'
gem 'trailblazer-operation' # Service objects for business logic
gem 'dry-validation'
gem 'ruby-enum'

## Extensions
gem 'hashie'

group :test do
  gem 'rspec'
  gem 'fabrication'
  gem 'faker', git: 'https://github.com/stympy/faker.git', branch: 'master'
  gem 'database_cleaner'
  gem 'mock_redis'
end
