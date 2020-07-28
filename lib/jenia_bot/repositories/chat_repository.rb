module JeniaBot
  class ChatRepository < Telegram::AppManager::BaseRepository
    include Telegram::AppManager::BaseRepositories::ChatRepository

    private

    def model
      JeniaBot::Chat
    end

  end
end
