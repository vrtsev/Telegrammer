module PdrBot
  class MessageRepository < Telegram::AppManager::BaseRepository
    include Telegram::AppManager::BaseRepositories::MessageRepository

    private

    def model
      PdrBot::Message
    end

  end
end
