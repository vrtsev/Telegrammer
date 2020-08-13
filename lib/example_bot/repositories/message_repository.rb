module ExampleBot
  class MessageRepository < Telegram::AppManager::BaseRepository
    DAYS_AGO_COUNT = 90

    def delete_old(days_ago_count=DAYS_AGO_COUNT)
      model
        .where { created_at < (Date.today - days_ago_count).to_time }
        .delete
    end

    private

    def model
      ExampleBot::Message
    end

  end
end
