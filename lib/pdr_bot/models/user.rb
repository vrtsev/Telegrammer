module PdrBot
  class User < Sequel::Model(:pdr_bot_users)
    include Telegram::AppManager::BaseModels::User
  end
end
