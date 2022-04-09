# frozen_string_literal: true

module ExampleBot
  module Responders
    class StartMessage < Telegram::AppManager::Responder
      def call
        respond_with(:message, text: start_message_text)
      end

      private

      def start_message_text
        t('example_bot.start_message')
      end
    end
  end
end
