# frozen_string_literal: true

module PdrBot
  module Responders
    class StartMessage < Telegram::AppManager::BaseResponder
      def call
        message(start_message, bot: Telegram.bots[:pdr_bot], chat_id: params[:current_chat_id]).send
      end

      def start_message
        I18n.t('.pdr_bot.start_message', bot_author: params[:bot_author]).sample
      end
    end
  end
end
