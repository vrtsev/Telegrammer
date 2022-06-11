# frozen_string_literal: true

require_all 'apps/jenia_bot/templates'
require_all 'apps/bot_base'
require_relative 'controller.rb'

module JeniaBot
  class Application < Telegram::AppManager::Application
    config.app_name = 'JeniaBot'
    config.environment = ENV['APP_ENV']
    config.telegram_bot = Telegram.bots[:jenia_bot]
    config.controller = JeniaBot::Controller
    config.controller_action_logging = true
  end
end
