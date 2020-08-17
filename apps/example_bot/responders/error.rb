# frozen_string_literal: true

module ExampleBot
  module Responders
    class Error < Telegram::AppManager::BaseResponder
      def call
        message(
          params[:error_msg],
          bot: Telegram.bots[:example_bot],
          chat_id: params[:current_chat_id]
        ).send
      end
    end
  end
end
