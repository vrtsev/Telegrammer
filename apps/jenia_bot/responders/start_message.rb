# frozen_string_literal: true

module JeniaBot
  module Responders
    class StartMessage < Telegram::AppManager::BaseResponder
      def call
        send_message(start_message, bot: Telegram.bots[:jenia_bot], chat_id: params[:current_chat_id])
      end

      def start_message
        ::JeniaBot.localizer.pick('start_message', bot_author: params[:bot_author])
      end
    end
  end
end
