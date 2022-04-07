# frozen_string_literal: true

require './config/environment.rb'

# Load codebase here
require './lib/telegram/app_manager.rb'
require './lib/application.rb'

# Load bot applications
require './apps/pdr_bot/application.rb'
require './apps/jenia_bot/application.rb'
require './apps/example_bot/application.rb'
