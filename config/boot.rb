# frozen_string_literal: true

require './config/environment.rb'

# Load codebase here
require './lib/telegram/app_manager.rb'

require './lib/pdr_bot.rb'
require './apps/pdr_bot/application.rb'

require './lib/jenia_bot.rb'
require './apps/jenia_bot/application.rb'

require './lib/example_bot.rb'
require './apps/example_bot/application.rb'

require './lib/admin_bot.rb'
require './apps/admin_bot/application.rb'
