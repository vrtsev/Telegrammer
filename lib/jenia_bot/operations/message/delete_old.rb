# frozen_string_literal: true

module JeniaBot
  module Op
    module Message
      class DeleteOld < Telegram::AppManager::BaseOperation
        OLD_MESSAGES_AGE = 90 # days

        step :delete_messages

        def delete_messages(ctx, **)
          JeniaBot::MessageRepository.new.delete_old(OLD_MESSAGES_AGE)
        end
      end
    end
  end
end
