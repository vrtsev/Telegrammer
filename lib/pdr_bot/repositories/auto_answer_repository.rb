module PdrBot
  class AutoAnswerRepository < Telegram::AppManager::BaseRepository
    include Telegram::AppManager::BaseRepositories::AutoAnswerRepository

    private

    def model
      PdrBot::AutoAnswer
    end

  end
end
