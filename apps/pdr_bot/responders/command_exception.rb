# frozen_string_literal: true

module PdrBot
  module Responders
    class CommandException < Telegram::AppManager::Responder
      def call
        respond_with(:message, text: error_text)
      end

      private

      def error_text
        Translation.for('pdr_bot.command_exception')
      end
    end
  end
end
