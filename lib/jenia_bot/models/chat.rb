module JeniaBot
  class Chat < Sequel::Model(:jenia_bot_chats)
    include Telegram::AppManager::BaseModels::Chat
  end
end
