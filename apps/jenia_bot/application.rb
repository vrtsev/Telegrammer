# frozen_string_literal: true

require_all 'apps/jenia_bot/responders'
require_relative 'controller.rb'

module JeniaBot
  class Application < Telegram::AppManager::Application
    configure do |config|
      config.app_name = 'JeniaBot'
      config.telegram_bot = Telegram.bots[:jenia_bot]
      config.controller = JeniaBot::Controller
      config.controller_logging = true
    end
  end
end
