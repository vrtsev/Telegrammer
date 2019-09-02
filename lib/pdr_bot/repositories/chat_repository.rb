module PdrBot
  class ChatRepository < Telegram::AppManager::BaseRepository

    private

    def model
      PdrBot::Chat
    end

  end
end
