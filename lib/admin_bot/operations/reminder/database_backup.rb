module AdminBot
  module Op
    module Reminder
      class DatabaseBackup < Telegram::AppManager::BaseOperation

        pass :pick_message
        pass :send_message

        def pick_message(ctx, **)
          ctx[:message] = AdminBot.localizer.pick('reminder.database_backup.message')
        end

        def send_message(ctx, **)
          Telegram::BotManager::Message.new(
            ::AdminBot.bot, ctx[:message]
          ).send_to_app_owner
        end

      end
    end
  end
end
