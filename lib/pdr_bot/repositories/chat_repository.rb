module PdrBot
  class ChatRepository < Telegram::AppManager::BaseRepository
    include Telegram::AppManager::BaseRepositories::ChatRepository

    private

    def model
      PdrBot::Chat
    end

  end
end
