# frozen_string_literal: true

module PdrBot
  module Responders
    class StartMessage < Telegram::AppManager::Responder
      def call
        respond_with(:message, text: start_message_text)
      end

      private

      def start_message_text
        t('pdr_bot.start_message')
      end
    end
  end
end
