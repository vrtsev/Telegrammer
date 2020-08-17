# frozen_string_literal: true

module ExampleBot
  module Responders
    class ApplicationCrash < Telegram::AppManager::BaseResponder
      def call
        message(
          text,
          bot: Telegram.bots[:example_bot],
          chat_id: params[:current_chat_id]
        ).send
      end

      private

      def text
        I18n.t('.example_bot.errors').sample
      end
    end
  end
end
