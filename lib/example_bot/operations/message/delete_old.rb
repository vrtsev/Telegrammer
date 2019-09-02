module ExampleBot
  module Op
    module Message
      class DeleteOld < Telegram::AppManager::BaseOperation

        step :delete_messages

        def delete_messages(ctx, **)
          ExampleBot::MessageRepository.new.delete_old
        end

      end
    end
  end
end
