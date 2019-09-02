module PdrBot
  class StatRepository < Telegram::AppManager::BaseRepository

    def find_by_chat_and_user(chat_id, user_id)
      model
        .left_join(:pdr_bot_users, id: :user_id)
        .where(chat_id: chat_id, user_id: user_id)
        .first
    end

    def find_all_by_chat_id(chat_id)
      model
        .left_join(:pdr_bot_users, id: :user_id)
        .where(chat_id: chat_id)
        .to_a
    end

    def find_leader_by_chat_id(chat_id:, counter:)
      model
        .left_join(:pdr_bot_users, id: :user_id)
        .where(chat_id: chat_id)
        .order(counter)
        .last
    end

    def increment(counter, chat_id:, user_id:)
      model.dataset
        .returning(counter)
        .where(chat_id: chat_id, user_id: user_id)
        .update(counter => Sequel.expr(1) + counter)
    end

    private

    def model
      PdrBot::Stat
    end

  end
end
