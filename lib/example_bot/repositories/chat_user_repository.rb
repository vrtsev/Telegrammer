module ExampleBot
  class ChatUserRepository < Telegram::AppManager::BaseRepository
    include Telegram::AppManager::BaseRepositories::ChatUserRepository

    private

    def model
      ExampleBot::ChatUser
    end

  end
end
