# frozen_string_literal: true

module JeniaBot
  module Responders
    class AutoAnswer < Telegram::AppManager::BaseResponder
      def call
        message(
          params[:auto_answer],
          bot: Telegram.bots[:jenia_bot],
          chat_id: params[:current_chat_id]
        ).reply(message_id: params[:current_message_id])
      end
    end
  end
end
