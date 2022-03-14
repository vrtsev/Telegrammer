# frozen_string_literal: true

module JeniaBot
  module Responders
    class StartMessage < Telegram::AppManager::Responder
      def call
        respond_with(:message, text: start_message_text)
      end

      private

      def start_message_text
        Translation.for('jenia_bot.start_message')
      end
    end
  end
end
