module JeniaBot
  class ChatUserRepository < Telegram::AppManager::BaseRepository
    def find_by_chat_and_user(chat_id:, user_id:)
      model.where(chat_id: chat_id, user_id: user_id).first
    end

    def find_all_by_chat(chat_id)
      model.where(chat_id: chat_id).to_a
    end

    def users_count_by_chat_id(chat_id)
      model.where(chat_id: chat_id).count
    end

    def random_by_chat(chat_id, except_user_id: nil)
      result_set = model
        .where(chat_id: chat_id)
        .exclude(user_id: except_user_id)

      result_set.offset(Sequel.function(:floor, (Sequel.function(:random) * result_set.count)))
        .limit(1)
        .first
    end

    private

    def model
      JeniaBot::ChatUser
    end

  end
end
