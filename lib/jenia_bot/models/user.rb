module JeniaBot
  class User < Sequel::Model(:jenia_bot_users)
    include Telegram::AppManager::BaseModels::User
  end
end
