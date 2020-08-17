# frozen_string_literal: true

module PdrBot
  module Responders
    class ApplicationCrash < Telegram::AppManager::BaseResponder
      def call
        message(
          text,
          bot: Telegram.bots[:pdr_bot],
          chat_id: params[:current_chat_id]
        ).send
      end

      private

      def text
        I18n.t('.pdr_bot.errors').sample
      end
    end
  end
end
