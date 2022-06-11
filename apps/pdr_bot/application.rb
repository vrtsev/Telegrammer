# frozen_string_literal: true

require_all 'apps/pdr_bot/responders'
require_relative 'controller.rb'

module PdrBot
  class Application < Telegram::AppManager::Application
    config.app_name = 'PdrBot'
    config.environment = ENV['APP_ENV']
    config.telegram_bot = Telegram.bots[:pdr_bot]
    config.controller = PdrBot::Controller
    config.controller_action_logging = true
  end
end
