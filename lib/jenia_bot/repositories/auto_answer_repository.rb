# frozen_string_literal: true

module JeniaBot
  class AutoAnswerRepository < Telegram::AppManager::BaseRepository
    def all_desc
      model.order(Sequel.desc(:trigger)).to_a
    end

    def find_approved_random_answer(_chat_id, message)
      return unless message.present?

      model
        .where(approved: true)
        .where(Sequel.ilike(:trigger, "%#{message}%"))
        .to_a
        .sample
    end

    private

    def model
      JeniaBot::AutoAnswer
    end
  end
end
