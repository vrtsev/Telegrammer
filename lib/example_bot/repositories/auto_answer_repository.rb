module ExampleBot
  class AutoAnswerRepository < Telegram::AppManager::BaseRepository
    include Telegram::AppManager::BaseRepositories::AutoAnswerRepository

    def find_by_trigger(trigger)
      model.where(trigger: trigger).to_a
    end

    def find_approved_random_answer(chat_id, message)
      return unless message.present?

      # .where(approved: true, chat_id: chat_id)
      model
        .where(approved: true)
        .where(Sequel.ilike(:trigger, "%#{message}%"))
        .to_a
        .sample
    end

    private

    def model
      ExampleBot::AutoAnswer
    end

  end
end
