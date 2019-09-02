module AdminBot
  class User < Sequel::Model(:admin_bot_users)
    include Telegram::AppManager::BaseModels::User

    class Roles
      include Ruby::Enum

      define :not_approved, 0
      define :moderator, 1
      define :administrator, 2
    end
  end
end
