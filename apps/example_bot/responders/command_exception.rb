# frozen_string_literal: true

module ExampleBot
  module Responders
    class CommandException < Telegram::AppManager::Responder
      def call
        respond_with(:message, text: error_text)
      end

      private

      def error_text
        Translation.for('example_bot.command_exception')
      end
    end
  end
end
