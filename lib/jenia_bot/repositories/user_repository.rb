module JeniaBot
  class UserRepository < Telegram::AppManager::BaseRepository

    private

    def model
      JeniaBot::User
    end

  end
end
