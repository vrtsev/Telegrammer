# frozen_string_literal: false

# Require web-related libs
require 'zeitwerk'
require 'hanami/view'
require 'hanami/router'
require 'hanami/controller'

# Require codebase
require './config/environment.rb'
require './lib/admin_bot.rb'
require './lib/example_bot.rb'
require './lib/jenia_bot.rb'
require './lib/pdr_bot.rb'
require './lib/web.rb'

require_relative 'application.rb'
require_relative 'routes.rb'
run WEB_APP
