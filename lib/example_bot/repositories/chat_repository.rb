module ExampleBot
  class ChatRepository < Telegram::AppManager::BaseRepository

    private

    def model
      ExampleBot::Chat
    end

  end
end
