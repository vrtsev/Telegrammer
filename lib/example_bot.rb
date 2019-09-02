require_all './lib/example_bot'

module ExampleBot
  include Telegram::BotManager::BotClassMethods

  configure do |config|
    config.app_name = 'ExampleBot'
    config.locale = 'example_bot'
    config.localizer = Telegram::BotManager::Localizer.new(locale)
    config.logger = Telegram::BotManager::BotLogger.new(app_name)
    config.bot = Telegram.bots[:example_bot]
  end
end
