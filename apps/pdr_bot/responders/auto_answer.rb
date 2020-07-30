# frozen_string_literal: true

module PdrBot
  module Responders
    class AutoAnswer < Telegram::AppManager::BaseResponder
      def call
        sleep(rand(2..4))

        reply_message(
          params[:auto_answer],
          bot: Telegram.bots[:pdr_bot],
          chat_id: params[:current_chat_id],
          message_id: params[:current_message_id]
        )
      end
    end
  end
end
