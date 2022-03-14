# frozen_string_literal: true

require_all 'apps/pdr_bot/responders'
require_relative 'controller.rb'

module PdrBot
  class Application < Telegram::AppManager::Application
    configure do |config|
      config.app_name = 'PdrBot'
      config.telegram_bot = Telegram.bots[:pdr_bot]
      config.controller = PdrBot::Controller
      config.controller_logging = true
    end
  end
end
