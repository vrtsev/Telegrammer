# require_all './lib/my_bot'

# module MyBot
#   include Telegram::BotManager::BotClassMethods

#   configure do |config|
#     config.app_name = 'MyBot'
#     config.locale = 'jenia_bot'
#     config.localizer = Telegram::BotManager::Localizer.new(locale)
#     config.logger = Telegram::BotManager::BotLogger.new(app_name)
#     config.bot = Telegram.bots[:my_bot]
#   end
# end
