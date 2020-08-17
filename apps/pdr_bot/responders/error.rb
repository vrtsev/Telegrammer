# frozen_string_literal: true

module PdrBot
  module Responders
    class Error < Telegram::AppManager::BaseResponder
      def call
        message(
          params[:error_msg],
          bot: Telegram.bots[:pdr_bot],
          chat_id: params[:current_chat_id]
        ).send
      end
    end
  end
end
