require_relative './pdr_bot'
require_relative './jenia_bot'
require_relative './example_bot'

require_all './lib/admin_bot'

module AdminBot
  include Telegram::AppManager::BotClassMethods

  configure do |config|
    config.app_name = 'AdminBot'
    config.locale = 'admin_bot'
    config.localizer = Telegram::AppManager::Localizer.new(locale)
    config.logger = Telegram::AppManager::BotLogger.new(app_name)
    config.bot = Telegram.bots[:admin_bot]
  end
end

