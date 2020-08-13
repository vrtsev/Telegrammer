require_all './lib/example_bot'

module ExampleBot
  include Telegram::AppManager::Bot::ClassMethods

  configure do |config|
    config.app_name = 'ExampleBot'
    config.default_locale = ENV['EXAMPLE_BOT_DEFAULT_LOCALE']
    config.logger = Telegram::AppManager::Logger.new("log/#{app_name}.log")
    config.bot = Telegram.bots[:example_bot]
  end
end
