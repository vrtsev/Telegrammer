# frozen_string_literal: true

module JeniaBot
  module Responders
    class Error < Telegram::AppManager::BaseResponder
      def call
        message(
          params[:error_msg],
          bot: Telegram.bots[:jenia_bot],
          chat_id: params[:current_chat_id]
        ).send
      end
    end
  end
end
