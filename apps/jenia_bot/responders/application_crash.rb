# frozen_string_literal: true

module JeniaBot
  module Responders
    class ApplicationCrash < Telegram::AppManager::BaseResponder
      def call
        send_message(
          text,
          bot: Telegram.bots[:jenia_bot],
          chat_id: params[:current_chat_id]
        )
      end

      private

      def text
        I18n.t('.jenia_bot.errors').sample
      end
    end
  end
end
