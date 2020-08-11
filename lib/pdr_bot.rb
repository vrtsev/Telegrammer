require_all './lib/pdr_bot'

module PdrBot
  include Telegram::AppManager::BotClassMethods

  configure do |config|
    config.app_name = 'PdrBot'
    config.default_locale = ENV['PDR_BOT_DEFAULT_LOCALE']
    config.logger = Telegram::AppManager::BotLogger.new(app_name)
    config.bot = Telegram.bots[:pdr_bot]
  end
end
