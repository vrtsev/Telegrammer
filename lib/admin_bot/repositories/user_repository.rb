module AdminBot
  class UserRepository < Telegram::AppManager::BaseRepository

    private

    def model
      AdminBot::User
    end

  end
end
