require_relative './pdr_bot'
require_relative './jenia_bot'
require_relative './example_bot'

require_all './lib/admin_bot'

module AdminBot
  include Telegram::AppManager::Bot::ClassMethods

  configure do |config|
    config.app_name = 'AdminBot'
    config.default_locale = ENV['ADMIN_BOT_DEFAULT_LOCALE']
    config.logger = Telegram::AppManager::Logger.new("log/#{app_name}.log")
    config.bot = Telegram.bots[:admin_bot]
  end
end

