module PdrBot
  module Op
    module Reminder
      class BookTable < Telegram::AppManager::BaseOperation

        pass :pick_message
        pass :send_message

        def pick_message(ctx, **)
          ctx[:message] = PdrBot.localizer.pick(:'reminders.book_table')
        end

        def send_message(ctx, **)
          Telegram::BotManager::Message.new(
            ::PdrBot.bot, ctx[:message]
          ).send_to_chat(ENV['PDR_BOT_PUBLIC_CHAT_ID'])
        end

      end
    end
  end
end
