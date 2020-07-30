# frozen_string_literal: true

module PdrBot
  module Responders
    class StartMessage < Telegram::AppManager::BaseResponder
      def call
        send_message(start_message, bot: Telegram.bots[:pdr_bot], chat_id: params[:current_chat_id])
      end

      def start_message
        ::PdrBot.localizer.pick('start_message', bot_author: ENV['TELEGRAM_APP_OWNER_USERNAME'])
      end
    end
  end
end
