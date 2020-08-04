# frozen_string_literal: true

module ExampleBot
  module Responders
    class StartMessage < Telegram::AppManager::BaseResponder
      def call
        send_message(start_message, bot: Telegram.bots[:example_bot], chat_id: params[:current_chat_id])
      end

      def start_message
        ::ExampleBot.localizer.pick('start_message', bot_author: params[:bot_author])
      end
    end
  end
end
