module JeniaBot
  module Op
    module Message
      class DeleteOld < Telegram::AppManager::BaseOperation

        step :delete_messages

        def delete_messages(ctx, **)
          JeniaBot::MessageRepository.new.delete_old
        end

      end
    end
  end
end
