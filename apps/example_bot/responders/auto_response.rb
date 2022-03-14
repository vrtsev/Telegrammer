# frozen_string_literal: true

module ExampleBot
  module Responders
    class AutoResponse < Telegram::AppManager::Responder
      def call
        reply_with(:message, text: response_text)
      end

      private

      def response_text
        params[:response].present? ? params[:response] : received_message
      end

      def received_message
        Translation.for('example_bot.auto_response', message: current_message.text)
      end
    end
  end
end
