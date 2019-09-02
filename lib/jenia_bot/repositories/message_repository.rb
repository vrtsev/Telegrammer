module JeniaBot
  class MessageRepository < Telegram::AppManager::BaseRepository
    include Telegram::AppManager::BaseRepositories::MessageRepository

    private

    def model
      JeniaBot::Message
    end

  end
end
