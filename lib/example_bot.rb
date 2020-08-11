require_all './lib/example_bot'

module ExampleBot
  include Telegram::AppManager::BotClassMethods

  configure do |config|
    config.app_name = 'ExampleBot'
    config.default_locale = ENV['EXAMPLE_BOT_DEFAULT_LOCALE']
    config.localizer = Telegram::AppManager::Localizer.new(locale)
    config.logger = Telegram::AppManager::BotLogger.new(app_name)
    config.bot = Telegram.bots[:example_bot]
  end
end
