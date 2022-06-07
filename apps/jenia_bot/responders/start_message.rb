# frozen_string_literal: true

module JeniaBot
  module Responders
    class StartMessage < ApplicationResponder
      def call
        respond_with(:message, text: start_message_text)
      end

      private

      def start_message_text
        t('jenia_bot.start_message')
      end
    end
  end
end
