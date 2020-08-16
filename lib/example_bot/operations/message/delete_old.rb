# frozen_string_literal: true

module ExampleBot
  module Op
    module Message
      class DeleteOld < Telegram::AppManager::BaseOperation
        OLD_MESSAGES_AGE = 90 # days

        step :delete_messages

        def delete_messages(ctx, **)
          ExampleBot::MessageRepository.new.delete_old(OLD_MESSAGES_AGE)
        end
      end
    end
  end
end
