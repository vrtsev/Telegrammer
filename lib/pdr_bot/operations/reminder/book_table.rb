module PdrBot
  module Op
    module Reminder
      class BookTable < Telegram::AppManager::BaseOperation

        pass :pick_message
        pass :check_bot_state
        pass :send_message

        def pick_message(ctx, **)
          ctx[:message] = PdrBot.localizer.pick(:'reminders.book_table')
        end

        def check_bot_state(ctx, **)
          ctx[:bot_enabled] = ::PdrBot::Op::Bot::State.call[:enabled]
        end

        def send_message(ctx, **)
          return unless ctx[:bot_enabled]

          Telegram::BotManager::Message.new(
            ::PdrBot.bot, ctx[:message]
          ).send_to_chat(ENV['PDR_BOT_PUBLIC_CHAT_ID'])
        end

      end
    end
  end
end
