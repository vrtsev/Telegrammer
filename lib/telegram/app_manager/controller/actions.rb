# frozen_string_literal: true

module Telegram
  module AppManager
    class Controller < Telegram::Bot::UpdatesController
      module Actions
        def enable!
          bot_setting.update!(enabled: true)
          reply_with(:message, text: 'Bot has been enabled', chat_id: ENV['TELEGRAM_APP_OWNER_ID'])
        end

        def disable!
          bot_setting.update!(enabled: false)
          reply_with(:message, text: 'Bot has been disabled', chat_id: ENV['TELEGRAM_APP_OWNER_ID'])
        end
      end
    end
  end
end
