require_all './lib/jenia_bot'

module JeniaBot
  include Telegram::AppManager::Bot::ClassMethods

  configure do |config|
    config.app_name = 'JeniaBot'
    config.default_locale = ENV['JENIA_BOT_DEFAULT_LOCALE']
    config.logger = Telegram::AppManager::BotLogger.new(app_name)
    config.bot = Telegram.bots[:jenia_bot]
  end
end
