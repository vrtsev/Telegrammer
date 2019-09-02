# frozen_string_literal: true

module Telegram
  module AppManager
    module BaseRepositories
      module AutoAnswerRepository

        def find_approved_random_answer(chat_id, message)
          return unless message.present?

          model
            .where(approved: true, chat_id: chat_id)
            .where(Sequel.ilike(:trigger, "%#{message}%"))
            .to_a
            .sample
        end

      end
    end
  end
end

