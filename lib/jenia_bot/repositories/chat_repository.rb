module JeniaBot
  class ChatRepository < Telegram::AppManager::BaseRepository

    private

    def model
      JeniaBot::Chat
    end

  end
end
