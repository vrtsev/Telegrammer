module PdrBot
  class AutoAnswerRepository < Telegram::AppManager::BaseRepository
    def find_approved_random_answer(chat_id, message)
      return unless message.present?

      model
        .where(approved: true, chat_id: chat_id)
        .where(ilike_pattern(['% ', ' %'], message, :trigger))
        .or(ilike_pattern(['', ' %'], message, :trigger))
        .or(ilike_pattern(['% ', ''], message, :trigger))
        .to_a
        .sample
    end

    private

    def ilike_pattern(pattern, message, column)
      Sequel.ilike(message, Sequel.join(pattern, Sequel[column]))
    end

    def model
      PdrBot::AutoAnswer
    end
  end
end
