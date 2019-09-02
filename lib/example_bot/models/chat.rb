module ExampleBot
  class Chat < Sequel::Model(:example_bot_chats)
    include Telegram::AppManager::BaseModels::Chat
  end
end
