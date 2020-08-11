require_all './lib/jenia_bot'

module JeniaBot
  include Telegram::AppManager::BotClassMethods

  configure do |config|
    config.app_name = 'JeniaBot'
    config.locale = 'jenia_bot'
    config.localizer = Telegram::AppManager::Localizer.new(locale)
    config.logger = Telegram::AppManager::BotLogger.new(app_name)
  end
end
