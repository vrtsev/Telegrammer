module JeniaBot
  class MessageRepository < Telegram::AppManager::BaseRepository
    def delete_old(age)
      model
        .where { created_at < (Date.today - age).to_time }
        .delete
    end

    private

    def model
      JeniaBot::Message
    end

  end
end
