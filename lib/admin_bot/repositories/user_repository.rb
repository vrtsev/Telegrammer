module AdminBot
  class UserRepository < Telegram::AppManager::BaseRepository
    def find_by_login(login)
      model.where(username: login).first
    end

    private

    def model
      AdminBot::User
    end
  end
end
