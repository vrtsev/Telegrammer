# frozen_string_literal: true

# module MyBot
#   class AutoAnswerRepository < Telegram::AppManager::BaseRepository
#     include Telegram::AppManager::BaseRepositories::AutoAnswerRepository

#     def find_approved_random_answer(chat_id, message)
#       return unless message.present?

#       model
#         .where(approved: true, chat_id: chat_id)
#         .where(Sequel.ilike(:trigger, "%#{message}%"))
#         .to_a
#         .sample
#     end

#     private

#     def model
#       MyBot::AutoAnswer
#     end

#   end
# end
