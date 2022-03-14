# frozen_string_literal: true

require_all 'apps/example_bot/responders'
require_relative 'controller.rb'

module ExampleBot
  class Application < Telegram::AppManager::Application
    configure do |config|
      config.app_name = 'ExampleBot'
      config.telegram_bot = Telegram.bots[:example_bot]
      config.controller = ExampleBot::Controller
      config.controller_logging = true
    end
  end
end
