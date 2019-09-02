module PdrBot
  class Chat < Sequel::Model(:pdr_bot_chats)
    include Telegram::AppManager::BaseModels::Chat
  end
end
