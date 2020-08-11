require_all './lib/example_bot'

module ExampleBot
  include Telegram::AppManager::BotClassMethods

  configure do |config|
    config.app_name = 'ExampleBot'
    config.locale = 'example_bot'
    config.localizer = Telegram::AppManager::Localizer.new(locale)
    config.logger = Telegram::AppManager::BotLogger.new(app_name)
  end
end
