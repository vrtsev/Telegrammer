require_all './lib/pdr_bot'

module PdrBot
  include Telegram::AppManager::BotClassMethods

  configure do |config|
    config.app_name = 'PdrBot'
    config.locale = 'pdr_bot'
    config.localizer = Telegram::AppManager::Localizer.new(locale)
    config.logger = Telegram::AppManager::BotLogger.new(app_name)
  end
end
