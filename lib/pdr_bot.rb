# frozen_string_literal: false

require_all './lib/pdr_bot'

module PdrBot
  include Telegram::AppManager::Bot::ClassMethods

  configure do |config|
    config.app_name = 'PdrBot'
    config.default_locale = ENV['PDR_BOT_DEFAULT_LOCALE']
    config.logger = Telegram::AppManager::Logger.new("log/#{app_name}.log")
    config.bot = Telegram.bots[:pdr_bot]
  end
end
