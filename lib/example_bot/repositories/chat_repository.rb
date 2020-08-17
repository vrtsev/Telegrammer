# frozen_string_literal: true

module ExampleBot
  class ChatRepository < Telegram::AppManager::BaseRepository
    private

    def model
      ExampleBot::Chat
    end
  end
end
