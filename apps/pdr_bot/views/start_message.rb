module PdrBot
  module Views
    class StartMessage < Telegram::AppManager::BaseView

      def text
        content << ::PdrBot.localizer.pick('start_message',
          bot_author: ENV['TELEGRAM_APP_OWNER_USERNAME']
        )
      end

    end
  end
end
