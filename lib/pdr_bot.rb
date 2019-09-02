require_all './lib/pdr_bot'

module PdrBot
  include Telegram::BotManager::BotClassMethods

  configure do |config|
    config.app_name = 'PdrBot'
    config.locale = 'pdr_bot'
    config.localizer = Telegram::BotManager::Localizer.new(locale)
    config.logger = Telegram::BotManager::BotLogger.new(app_name)
    config.bot = Telegram.bots[:pdr_bot]
  end
end
