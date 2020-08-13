module PdrBot
  class GameRoundRepository < Telegram::AppManager::BaseRepository
    def find_latest_by_chat_id(chat_id)
      model.where(chat_id: chat_id).order(:created_at).last
    end

    private

    def model
      PdrBot::GameRound
    end
  end
end
