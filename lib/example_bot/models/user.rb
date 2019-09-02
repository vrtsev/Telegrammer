module ExampleBot
  class User < Sequel::Model(:example_bot_users)
    include Telegram::AppManager::BaseModels::User
  end
end
