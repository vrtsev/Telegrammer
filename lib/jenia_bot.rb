require_all './lib/jenia_bot'

module JeniaBot
  include Telegram::BotManager::BotClassMethods

  configure do |config|
    config.app_name = 'JeniaBot'
    config.locale = 'jenia_bot'
    config.localizer = Telegram::BotManager::Localizer.new(locale)
    config.logger = Telegram::BotManager::BotLogger.new(app_name)
    config.bot = Telegram.bots[:jenia_bot]
  end
end
