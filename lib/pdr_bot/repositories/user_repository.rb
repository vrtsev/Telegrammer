# frozen_string_literal: true

module PdrBot
  class UserRepository < Telegram::AppManager::BaseRepository
    private

    def model
      PdrBot::User
    end
  end
end
