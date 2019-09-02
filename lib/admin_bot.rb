require_relative './pdr_bot'
require_relative './jenia_bot'
require_relative './example_bot'

require_all './lib/admin_bot'

module AdminBot
  include Telegram::BotManager::BotClassMethods

  configure do |config|
    config.app_name = 'AdminBot'
    config.locale = 'admin_bot'
    config.localizer = Telegram::BotManager::Localizer.new(locale)
    config.logger = Telegram::BotManager::BotLogger.new(app_name)
    config.bot = Telegram.bots[:admin_bot]
  end

end

