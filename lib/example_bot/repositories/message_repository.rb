module ExampleBot
  class MessageRepository < Telegram::AppManager::BaseRepository
    include Telegram::AppManager::BaseRepositories::MessageRepository

    private

    def model
      ExampleBot::Message
    end

  end
end
