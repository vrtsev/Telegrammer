module JeniaBot
  class ChatRepository < Telegram::AppManager::BaseRepository
    def get_all_desc
      model.order(Sequel.desc(:created_at)).to_a
    end

    private

    def model
      JeniaBot::Chat
    end

  end
end
