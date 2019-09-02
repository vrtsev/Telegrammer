module JeniaBot
  class ChatUserRepository < Telegram::AppManager::BaseRepository
    include Telegram::AppManager::BaseRepositories::ChatUserRepository

    private

    def model
      JeniaBot::ChatUser
    end

  end
end
