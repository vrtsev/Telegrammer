module PdrBot
  class ChatUserRepository < Telegram::AppManager::BaseRepository
    include Telegram::AppManager::BaseRepositories::ChatUserRepository

    private

    def model
      PdrBot::ChatUser
    end

  end
end
