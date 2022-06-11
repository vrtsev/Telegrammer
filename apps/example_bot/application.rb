# frozen_string_literal: true

require_all 'apps/example_bot/templates'
require_all 'apps/bot_base'
require_relative 'controller.rb'

module ExampleBot
  class Application < Telegram::AppManager::Application
    config.app_name = 'ExampleBot'
    config.environment = ENV['APP_ENV']
    config.telegram_bot = Telegram.bots[:example_bot]
    config.controller = ExampleBot::Controller
    config.controller_action_logging = true
  end
end
