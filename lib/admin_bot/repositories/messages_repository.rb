module AdminBot
  class MessageRepository < Telegram::AppManager::BaseRepository
    include Telegram::AppManager::BaseRepositories::MessageRepository

    private

    def model
      AdminBot::Message
    end

  end
end
