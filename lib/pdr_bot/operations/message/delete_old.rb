# frozen_string_literal: true

module PdrBot
  module Op
    module Message
      class DeleteOld < Telegram::AppManager::BaseOperation
        DAYS_AGO_COUNT = 90

        step :delete_messages

        def delete_messages(ctx, **)
          PdrBot::MessageRepository.new.delete_old
        end
      end
    end
  end
end
